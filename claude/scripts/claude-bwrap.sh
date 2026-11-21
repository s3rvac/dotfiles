#!/usr/bin/env bash
#
# Claude Code wrapper running `claude` through the Bubblewrap sandbox
# (https://github.com/containers/bubblewrap).
#
# Note: The goal of the wrapper is to improve the overall security with limited
# impact on usability. It is not meant to be a 100% solution that would
# drammatically impact usability, and neither it is meant to be used to handle
# untrusted directories and files.
#

set -u

# Everything handed to bwrap accumulates in this single array.
params=()

# Helpers
# ----------------------------------------------------------------------------

# Abort with an error message.
die() { echo "error: $*" >&2; exit 1; }

# Mount a path read-only at the same location, but only if it exists.
mount_ro() { [[ -e $1 ]] && params+=(--ro-bind "$1" "$1"); return 0; }

# Mount a path read-write at the same location, but only if it exists.
mount_rw() { [[ -e $1 ]] && params+=(--bind "$1" "$1"); return 0; }

# Export a variable inside the params.
export_var() { params+=(--setenv "$1" "$2"); }

# Unsets an environment variable.
unset_var() { params+=(--unsetenv "$1"); }

# Preflight checks
# ----------------------------------------------------------------------------

claude_bin="$HOME/.local/bin/claude"

command -v bwrap >/dev/null || die "bwrap not found in PATH"
[[ -x $claude_bin ]] || die "claude not found or not executable: $claude_bin"

# Only run from inside one of these directories (add more as needed). The
# working directory gets mounted read-write, and a mount of an arbitrary
# directory could expose (or override the protections of) the rest of the home
# directory, e.g., private SSH keys.
allowed_roots=(
	"$HOME/Data"
	"$HOME/Projects"
)

# Resolve symlinks so that the checks below cannot be bypassed via a symlink.
cwd=$(pwd -P) || die "cannot determine the current directory"

allowed=0
for root in "${allowed_roots[@]}"; do
	root=$(realpath -m "$root")
	[[ $cwd == "$root"/* ]] && { allowed=1; break; }
done
((allowed)) || die "refusing to run in $cwd (not inside any of: ${allowed_roots[*]})"

# Require a git repository so that the .git protections below apply.
[[ -e $cwd/.git ]] || die "refusing to run in $cwd (no .git inside)"

runtime_dir=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
user=${USER:-$(id -un)}

# Base filesystem and isolation
# ----------------------------------------------------------------------------

params+=(
	--unshare-all
	--share-net
	--die-with-parent
	--proc /proc
	--dev /dev
	--tmpfs /tmp
	--tmpfs /var/tmp
)

# System directories (read-only). On many distributions /bin, /sbin, /lib, and
# /lib64 are symlinks into /usr, so recreate them as symlinks.
for dir in /usr /lib /lib64 /bin /sbin; do
	if [[ -L $dir ]]; then
		params+=(--symlink "$(readlink "$dir")" "$dir")
	else
		mount_ro "$dir"
	fi
done

# Minimal /etc: DNS, TLS trust store, user/group lookups, dynamic linker cache,
# time zone, OS info, system-wide git config, system-wide SSH config, and font
# configuration.
for file in resolv.conf hosts ssl ca-certificates nsswitch.conf passwd group \
	ld.so.cache localtime os-release gitconfig ssh fonts; do
	mount_ro "/etc/$file"
done

export_var HOME "$HOME"
export_var USER "$user"

# User configuration and tooling
# ----------------------------------------------------------------------------

# Read-only:
for path in \
	"$HOME/.gitconfig" \
	"$HOME/.gitconfig.local" \
	"$HOME/.config/ccstatusline" \
	"$HOME/.config/gh" \
	"$HOME/.config/git" \
	"$HOME/.config/nvim" \
	"$HOME/.local/bin" \
	"$HOME/.local/lib" \
	"$HOME/.local/share/nvim/" \
	"$HOME/.local/libexec"; do
	mount_ro "$path"
done

# Claude Code keeps its version locks in ~/.local/state/claude/locks. Without
# write access, acquiring them fails with EROFS.
mkdir -p "$HOME/.local/state/claude"
mount_rw "$HOME/.local/state/claude"

# Writable:
for path in \
	"$HOME/.local/share/claude" \
	"$HOME/.npm" \
	"$HOME/.sage" \
	"$HOME/.claude"; do
	mount_rw "$path"
done

# Hooks are executed outside the sandbox on later runs, so they must not be
# modifiable from inside it.
mount_ro "$HOME/.claude/hooks"

# Keep Claude Code's config inside ~/.claude (as ~/.claude/.claude.json) instead
# of ~/.claude.json. A single file bind-mounted into the sandbox cannot be
# replaced via rename(), which Claude Code uses for atomic writes, so writes to
# it fail with EBUSY. Files inside a bind-mounted directory do not have this
# problem. This must be set here because it cannot be set via settings.json
# (that file is located via this variable).
export_var CLAUDE_CONFIG_DIR "$HOME/.claude"

# SSH
# ----------------------------------------------------------------------------

mount_ro "$HOME/.ssh/known_hosts"
mount_ro "$HOME/.ssh/config"

# Public keys only; private keys stay outside the sandbox.
for key in id_ed25519 id_rsa id_ecdsa; do
	mount_ro "$HOME/.ssh/$key.pub"
done

# Forward the agent so git-over-SSH works without exposing key material. Only
# the socket itself is mounted, not its parent directory (which may be /tmp or
# the whole runtime directory).
if [[ -n ${SSH_AUTH_SOCK:-} && -S $SSH_AUTH_SOCK ]]; then
	mount_ro "$SSH_AUTH_SOCK"
	export_var SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
fi

# Audio
# ----------------------------------------------------------------------------

# I run an audio command whenever Claude Code finishes with a task; I need to
# allow Pulseaudio to run that command.
mount_ro "$runtime_dir/pulse"

# X11
# ----------------------------------------------------------------------------

# Needed to allow copying of text from the terminal.
mount_ro /tmp/.X11-unix
if [[ -e ${XAUTHORITY:-} ]]; then
	mount_ro "$XAUTHORITY"
	export_var XAUTHORITY "$XAUTHORITY"
else
	mount_ro "$HOME/.Xauthority"
fi
[[ -n ${DISPLAY:-} ]] && export_var DISPLAY "$DISPLAY"

# Tmux
# ----------------------------------------------------------------------------

# Unset tmux-related variables as I do not want Claude Code to think I am
# inside tmux. I do not want to bind the tmux socket as anyone with it controls
# my tmux server. They can send-keys into other panes or run run-shell outside
# the sandbox. That's effectively a full sandbox escape.
unset_var TMUX
unset_var TMUX_PANE

# GPG
# ----------------------------------------------------------------------------

# ~/.gnupg is read-only so that the agent configuration (e.g., gpg-agent.conf)
# cannot be tampered with; the agent runs outside the sandbox. As a result,
# trustdb updates fail inside it. The agent socket directory is required for
# commit signing.

mount_ro "$HOME/.gnupg"

# Hide the private keys from the sandbox; signing goes through the agent, which
# runs outside it.
[[ -e $HOME/.gnupg/private-keys-v1.d ]] && params+=(--tmpfs "$HOME/.gnupg/private-keys-v1.d")

gpg_sockets=$(gpgconf --list-dirs socketdir 2>/dev/null || true)
[[ -n $gpg_sockets ]] && mount_rw "$gpg_sockets"

[[ -n ${GPG_SIGNING_KEY_ID:-} ]] && export_var GPG_SIGNING_KEY_ID "$GPG_SIGNING_KEY_ID"

# Working directory and launch
# ----------------------------------------------------------------------------

mount_rw "$cwd"
params+=(--chdir "$cwd")

# Git hooks and config are executed/used outside the sandbox later, so they must
# not be modifiable from inside it.
mount_ro "$cwd/.git/hooks"
mount_ro "$cwd/.git/config"

# I want to terminate Claude Code when it is not run inside bwrap to prevent
# running it accidentally outside of it; do the checking via the following
# environment variable.
export_var CLAUDE_IN_BWRAP 1

echo "--> Starting claude via bwrap..." >&2
exec bwrap "${params[@]}" -- "$claude_bin" "$@"

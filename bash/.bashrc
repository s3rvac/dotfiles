#------------------------------------------------------------------------------
# File:   $HOME/.bashrc
# Author: Petr Zemek <s3rvac@petrzemek.net>
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Path.
#------------------------------------------------------------------------------

export PATH

# Prepends $1 to $PATH, provided it is a directory and is not already in $PATH.
# Based on http://superuser.com/a/39995.
function prepend_to_path() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="$1:$PATH"
	fi
}

# Include the path to Ruby gems.
if command -v ruby &> /dev/null; then
	prepend_to_path "$(ruby -e 'puts Gem.user_dir')/bin"
fi

# Include the path to Go programs.
if command -v go &> /dev/null; then
	prepend_to_path "$(go env GOPATH)/bin"
fi

# Include the path to programs from Cargo crates (Rust).
prepend_to_path "$HOME/.cargo/bin"

# Include the path to local programs (used e.g. by pip).
prepend_to_path "$HOME/.local/bin"

# Include the home bin.
prepend_to_path "$HOME/bin"

#------------------------------------------------------------------------------
# Prompt.
#------------------------------------------------------------------------------

# Requires https://github.com/rcaloras/bash-preexec, which is sourced at the
# bottom of this file.

# General settings.
if [ "$(id -u)" -eq 0 ]; then
	PROMPT_COLOR_LEFT='\e[31m' # normal red
else
	PROMPT_COLOR_LEFT='\e[1m\e[34m' # bold blue
fi
PROMPT_COLOR_RIGHT='\e[2m\e[37m' # dim gray
PROMPT_COLOR_OFF='\e[0m'

function prompt_preexec() {
	# Store the time when the last command was executed.
	last_command_start_time=$(date +'%H:%M:%S')

	# Start the timer of the last executed command.
	last_command_timer=$EPOCHREALTIME
}
preexec_functions+=(prompt_preexec)

function prompt_precmd() {
	# We need to store the exit code of the last command as soon as possible so
	# that it does not get overwritten.
	last_exit_code="$?"

	# Evaluate the timer of the last executed command.
	if [ -z "$last_command_timer" ]; then
		last_command_runtime="0m0.000s"
	else
		# Add a leading zero because `bc` does not include it for numbers less
		# than one and `date` cannot handle those.
		local duration="0$(bc <<< "$EPOCHREALTIME - $last_command_timer")"
		last_command_runtime=$(date -d@"$duration" -u +'%-Mm%-S.%3Ns')
	fi
	unset last_command_timer
}
precmd_functions+=(prompt_precmd)

# Call both functions to ensure that all variables are properly initialied for
# the first propmt.
prompt_preexec
prompt_precmd

function prompt_show_mark_if_inside_screen() {
	if [ -n "$STY" ]; then
		echo '(screen) '
	fi
}

function prompt_show_mark_if_inside_virtualenv() {
	if [ -n "$VIRTUAL_ENV" ]; then
		echo '(venv) '
	fi
}

function prompt_command() {
	# Based on https://superuser.com/a/1203400
	#
	# Note: "\[" and "\]" are used so that bash can calculate the number of
	# printed characters so that the prompt does not do strange things when
	# editing the entered text.

	# Create the left-hand side prompt.
	PS1_lhs=''
	PS1_lhs+='$(prompt_show_mark_if_inside_screen)'
	PS1_lhs+='$(prompt_show_mark_if_inside_virtualenv)'
	PS1_lhs+="\[$PROMPT_COLOR_LEFT\]"
	# Add current time.
	PS1_lhs+='\A '
	# Add username and hostname.
	PS1_lhs+='\u@\h '
	# Add the current working directory.
	PS1_lhs+='\W '
	# Add prompt symbol.
	PS1_lhs+='\$'
	# Finalize the prompt.
	PS1_lhs+="\[$PROMPT_COLOR_OFF\] "

	# Create the right-hand side prompt.
	printf -v PS1_rhs "${PROMPT_COLOR_RIGHT}$last_command_runtime | $last_command_start_time ($last_exit_code)${PROMPT_COLOR_OFF}"
	# Strip ANSI commands before counting length.
	# From: https://www.commandlinefu.com/commands/view/12043/remove-color-special-escape-ansi-codes-from-text-with-sed
	PS1_rhs_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<< "$PS1_rhs")

	# The right-side prompt messes up with Midnight Commander's prompt, so do not
	# use the right prompt when running under MC.
	if [ -n "$MC_TMPDIR" ]; then
		unset PS1_rhs
		unset PS1_rhs_stripped
	fi

	# Create the final prompt.
	#
	# Save cursor position, jump to right hand edge, then go left N columns
	# where N is the length of the printable RHS string. Print the RHS string,
	# then return to the saved position and print the LHS prompt.
	#
	# Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
	local save='\e[s' # Save cursor position
	local rest='\e[u' # Restore cursor to save point
	PS1="\[${save}\e[${COLUMNS:-$(tput cols)}C\e[${#PS1_rhs_stripped}D${PS1_rhs}${rest}\]${PS1_lhs}"
}

PROMPT_COMMAND=prompt_command

#------------------------------------------------------------------------------
# Shell options.
#------------------------------------------------------------------------------

# Allow typing just 'dir' instead of 'cd dir'.
shopt -s autocd

# Automatically correct mistyped directory names.
shopt -s cdspell

# Check that a command found in the hash table exists before trying to execute
# it. If a hashed command no longer exists, a normal path search is performed.
shopt -s checkhash

# Check the window size after each command and, if necessary, update the values
# of the LINES and COLUMNS variables.
shopt -s checkwinsize

# Attempt to save all lines of a multi-line command in the same history entry.
# This allows easy re-editing of multi-line commands.
shopt -s cmdhist

# Enable extended pattern matching.
shopt -s extglob

# Enable recursive globbing with **.
shopt -s globstar

# Make the history list appended to the file named by the value of the HISTFILE
# variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# Allow re-editing of a failed history substitution.
shopt -s histreedit

# Enable completion of host names.
shopt -s hostcomplete

# Save multi-line commands to the history with embedded newlines rather than
# using semicolon separators where possible.
shopt -s lithist

# Do not attempt to search the PATH for possible completions when completion is
# attempted on an empty line.
shopt -s no_empty_cmd_completion

# Enable programmable completion.
shopt -s progcomp

# Show a notification when a job finishes.
set -o notify

# Enable vi-like motion when typing commands.
set -o vi

#------------------------------------------------------------------------------
# Completion.
#------------------------------------------------------------------------------

complete -f -X '!*.@(pdf|PDF)' okular
complete -f -X '!*.@(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG|xcf|bmp|BMP|pcx|PCX)' gimp gwenview
complete -f -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|QT|wmv|WMV|mp3|MP3|ogg|OGG|ogm|OGM|ogv|OGV|mp4|MP4|wav|WAV|asx|ASX|mng|MNG|m4v|mkv)' mplayer mpv vlc

# git
if [[ -f ~/.git-completion.bash ]]; then
	source ~/.git-completion.bash
fi
complete -o default -o nospace -F _git g

# kubectl
if command -v kubectl &> /dev/null; then
	source <(kubectl completion bash | sed s/kubectl/k/g)
fi

# tmuxinator
if [[ -f ~/.tmuxinator-completion.bash ]]; then
	source ~/.tmuxinator-completion.bash
fi

# Other aliases.
complete -o default v
complete -o default vd
complete -o default gv
complete -o default gvd

#------------------------------------------------------------------------------
# Colors.
#------------------------------------------------------------------------------

# ls
eval $(dircolors)
LS_COLORS="$LS_COLORS*.JPG=01;35:*.GIF=01;35:*.jpeg=01;35:*.pcx=01;35:*.png=01;35:*.pnm=01;35:*.bz2=01;31:*.mpg=01;38:*.mpeg=01;38:*.MPG=01;38:*.MPEG=01;38:*.m4v=01;038:*.mp4=01;038:*.swf=01;038:*.avi=01;38:*.AVI=01;38:*.wmv=01;38:*.WMV=01;38:*.asf=01;38:*.ASF=01;38:*.mov=01;38:*.MOV=01;38:*.mp3=01;39:*.ogg=01;39:*.MP3=01;39:*.Mp3=01;39"
alias ls='ls --color=auto'

# grep
# Export both these variables to ensure that grep on all systems use the same
# colors (GREP_COLOR is deprecated, but some grep versions still use it).
export GREP_COLOR='1;33'
export GREP_COLORS=$GREP_COLOR
# GREP_OPTIONS is deprecated, so use aliases.
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ripgrep
alias rg='rg --colors "match:fg:yellow" --colors "match:bg:black" --colors "match:style:bold"'

# gcc (available since gcc 4.9)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#------------------------------------------------------------------------------
# Miscellaneous.
#------------------------------------------------------------------------------

umask 022

# Disable generation of core files (-S changes the SOFT limit, which enables us
# to change the limit later if we change our mind).
ulimit -Sc 0

# Allow less to view *.gz etc. files.
if command -v lesspipe.sh &> /dev/null; then
	eval $(lesspipe.sh)
fi

#------------------------------------------------------------------------------
# Environment variables.
#------------------------------------------------------------------------------

# Editor.
export EDITOR=nvim
export VISUAL="$EDITOR"

# History.
export HISTSIZE=10000
export HISTFILESIZE=100000
export HISTTIMEFORMAT='%y-%m-%d %H:%M:%S '
export HISTIGNORE=' *:c:l:cd *:builtin cd *'
export HISTCONTROL=ignoreboth

# Pager.
export PAGER=less
export LESS='-iFRX -x4'

# Locale. I use en_US, but for some categories, I prefer en_GB. For example, I
# prefer dd/mm/yyyy (GB) to mm/dd/yyyy (US).
export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_PAPER=en_GB.UTF-8
export LC_MEASUREMENT=en_GB.UTF-8

# Prevent ls from putting quotes around files with spaces in their names. This
# behavior was introduced in coreutils-8.25. I like the original behavior (no
# quotes), which is what the following variable guarantees.
export QUOTING_STYLE=literal

# Make.
export MAKEFLAGS="-j$(nproc)"

# Make ls, du, df and possibly other programs report sizes in a human-readable
# way by default (e.g. `df` implicitly becomes `df -h`).
export BLOCKSIZE=human-readable

# Graphics.
export MESA_GLX_FX=fullscreen

# Disable the automatic prepending of "(virtualenv) " to the prompt when
# Python's virtualenv is activated. The reason is that I have a custom code for
# doing that.
export VIRTUAL_ENV_DISABLE_PROMPT=1

#------------------------------------------------------------------------------
# Terminal settings.
#------------------------------------------------------------------------------

# Disable flow control (Ctrl-S and Ctrl-Q) because I use the Ctrl-S shortcut in
# Vim.
stty -ixon 2> /dev/null

#------------------------------------------------------------------------------
# Useful aliases to save some typing.
#------------------------------------------------------------------------------

alias c='clear'
alias l='ls -lA --group-directories-first'
function mdc() { mkdir -p "$@" && eval cd "\"\$$#\""; }
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# 2018-03-17: Without TERM=linux, cargo no longer emits colored error messages.
alias cargo='TERM=linux cargo'
alias ds='du -hs'
alias dsa='du -h --all --max-depth=1 --one-file-system 2> /dev/null | sort -h'
alias e='grep -E'
alias er='grep -ErI'
alias gdb='gdb -quiet'
alias rust-gdb='rust-gdb -quiet'
# We have to force xterm-256color because mc does not work properly with
# screen-256color ($TERM used in tmux).
# The standard mc-wrapper.sh script makes an automatic cd into the last working
# directory when mc exits (by default, mc exits to the directory from which it
# was started).
# By disabling the mouse (--nomouse), it is possible to copy text through the
# terminal emulator.
alias mc='TERM=xterm-256color source /usr/lib/mc/mc-wrapper.sh --nomouse'
# I use Neovim as my primary editor (https://neovim.io/).
alias nv='nvim -p'
alias v='nv'
alias vi='nv'
alias vim='nv'
alias vd='nvim -d'
alias gv='nvim-qt -- -p'
alias gvim='gv'
alias gvd='nvim-qt -- -d'
# A git commit browser in Vim (https://github.com/junegunn/gv.vim).
function GV() { v -c ":GV $*" -c ":+tabclose"; }
alias m='make'
function M() { make "$@" && make install; }
alias news='newsboat -q'
alias notes='v ~/notes/ -c "cd %:p:h"'
alias todo='v ~/todo/todo.txt -c "cd %:p:h"'
alias tf='terraform'
alias tfmt='terraform fmt --recursive .'
if [ "$(id -u)" -eq 0 ]; then
	alias mntd='mount /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk && chown root:disk /mnt/disk && chmod 0770 /mnt/disk'
else
	alias mntd='sudo mount -o gid=disk,dmask=007,fmask=117 /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk'
fi
alias umntd='sudo umount /mnt/disk'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias g='git'
alias kc='kubectl'
alias kcx='kubectx'
alias py='python3'
alias py2='python2'
# Automatically disable flow control (Ctrl-S/Q) after reset because I use the
# Ctrl-S shortcut in Vim.
alias reset='reset && stty -ixon'
alias t='tmux'
alias Time='/usr/bin/time -v'
alias unzipa='for f in *.zip; do unzip "$f" && rm -f "$f"; done'
alias untara='for f in $(ls | grep "\.\(tar\|gz\|tgz\|bz2\)"); do tar xf "$f" && rm -f "$f"; done'
alias unrara='for f in *.rar; do unrar x "$f" && rm -f "$f"; done'
function zipd() { zip -rq "$1".zip "$1"; echo "$1".zip; }
alias valgrind-leak='valgrind --leak-check=full --show-leak-kinds=all'
alias valgrind-uninit='valgrind --track-origins=yes'
alias yt='yt-dlp'
alias yt-mp3='yt-dlp --format ba --extract-audio --audio-format mp3 -o "%(title)s-%(id)s.%(ext)s"'

# Some distributions install the binaries/scripts for the following commands
# under a different name, so unify that.
if command -v fdfind &> /dev/null; then
	alias fd='fdfind'
fi

# Common typos.
alias G='g'
alias gd='g d'
alias gl='g l'
alias gp='g p'
alias gs='g s'
alias gu='g u'

# Translation. It uses https://github.com/soimort/translate-shell, which has to
# be available in $PATH under name 'trs'.
alias toen='trs cs:en'
alias tocs='trs en:cs'

# Use Neovim to view manual pages.
#
# Note: The following (recommended) approach
#
#   export MANPAGER='nvim +Man!'
#
# does not work when Neovim is installed as an AppImage (opening a manual page
# results in "fuse: mount failed: Permission denied"). Hence, use the following
# approach that works.
function man() { /usr/bin/man "$@" | nvim +Man! -; }

# Run the given command with arguments through gdb.
function gdbc() { gdb -quiet -ex run --args "$@"; }

# Activates a Python virtual environment (or first creates one when none
# exists).
function pyve() {
	if [ -d "virtualenv" ]; then
		source virtualenv/bin/activate
	elif [ -d "venv" ]; then
		source venv/bin/activate
	else
		python3 -m venv virtualenv
		source virtualenv/bin/activate
		pip install --upgrade pip setuptools
	fi
}

# Prints memory usage of processes with the given name.
# Usage: mem PROG
function mem() {
	ps -eo rss,pid,euser,args:100 --sort -%mem | grep -v grep | grep -i $@ \
		| awk '{printf "%.1f", $1/1024 "MB"; $1=""; print }'
}

# Recursive sed.
# Usage: rsed -i 's/what/with-what/g'
function rsed() { find . -type f -exec sed "$@" {} \+; }

# Filter files from the given output.
# Usage: vim `grep -r PATTERN | files`
function files() { cut -d: -f1 | sort -u; }

# Opens files found by recursive egrep in Vim.
# Usage: ver PATTERN
function ver() { v $(er "$@" | files); }

# Removes trailing whitespace from the given file or directory.
# Usage: remove-trailing-whitespace [FILE|DIR]
function remove-trailing-whitespace() {
	if [ ! -z "$1" ]; then
		find "$1" -type f -exec sed -i 's/[[:blank:]]\+$//' {} \;
	else
		# When no argument was given, remove trailing whitespace from all files
		# under version control.
		git ls-files | xargs sed -i 's/[[:blank:]]\+$//'
	fi
}

# Removes duplicate empty lines from the given file or directory.
# Usage: remove-duplicate-empty-lines [FILE|DIR]
function remove-duplicate-empty-lines() {
	if [ ! -z "$1" ]; then
		find "$1" -type f -exec sed -i 'N;/^\n$/D;P;D;' {} \;
	else
		# When no argument was given, remove duplicate empty lines from all
		# files under version control.
		git ls-files | xargs sed -i 'N;/^\n$/D;P;D;'
	fi
}

# Conversions.
alias HEX="ruby -e 'printf(\"0x%X\n\", ARGV[0])'"
alias DEC="ruby -e 'printf(\"%d\n\", ARGV[0])'"
alias BIN="ruby -e 'printf(\"%bb\n\", ARGV[0])'"

# Apt aliases for Debian/Ubuntu.
alias apti='apt install'
alias apts='apt search'
alias aptr='apt remove'
alias aptp='apt purge'
alias aptu='apt update && apt upgrade'

#------------------------------------------------------------------------------
# Settings for fzf, a command-line fuzzy finder.
# https://github.com/junegunn/fzf
#------------------------------------------------------------------------------

# Default options.
FZF_COLORS='hl:#ffff60,hl+:#ffff60'
if command -v bat &> /dev/null; then
	FZF_PREVIEW_COMMAND='bat --style=numbers --color=always --line-range :50 {}'
else
	FZF_PREVIEW_COMMAND='nl -ba {}'
fi
export FZF_DEFAULT_OPTS="--no-mouse --reverse --multi --height 40% --border --color '$FZF_COLORS' --preview '$FZF_PREVIEW_COMMAND'"

# If available, use fd (https://github.com/sharkdp/fd) for listing files and
# directories.
if command -v fd &> /dev/null; then
	FZF_FD_COMMAND='fd --color=never --follow --hidden --no-ignore --exclude .git'
	export FZF_DEFAULT_COMMAND="$FZF_FD_COMMAND --type f"
	export FZF_ALT_C_COMMAND="$FZF_FD_COMMAND --type d"
fi

# Options for Ctrl+T: Paste the selected files and directories onto the command-line.
export FZF_CTRL_T_OPTS="--select-1 --exit-0"

# Options for Ctrl+R: Paste the selected command from history onto the command-line.
export FZF_CTRL_R_OPTS="--no-sort --no-preview --exact"

# Options for Alt+C: cd into the selected directory.
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

# Import completion and key bindings.
if [[ -d ~/.fzf ]]; then
	source ~/.fzf/key-bindings.bash
	source ~/.fzf/completion.bash
fi

#------------------------------------------------------------------------------
# RVM (Ruby Version Manager).
#------------------------------------------------------------------------------

if [[ -f /usr/local/rvm/scripts/rvm ]]; then
	source /usr/local/rvm/scripts/rvm
fi

if [[ -f /usr/local/rvm/scripts/completion ]]; then
	source /usr/local/rvm/scripts/completion
fi

#------------------------------------------------------------------------------
# Import other scripts/settings.
#------------------------------------------------------------------------------

# https://github.com/rcaloras/bash-preexec
if [[ -f ~/.bash_preexec ]]; then
	source ~/.bash_preexec
fi

# Local settings.
if [[ -f ~/.bashrc.local ]]; then
	source ~/.bashrc.local
fi

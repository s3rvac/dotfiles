#------------------------------------------------------------------------------
# File:   $HOME/.bashrc
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Based on http://www.hermann-uwe.de/files/bashrc.
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
prepend_to_path "$(ruby -e 'puts Gem.user_dir')/bin"

# Include the path to programs from Cargo crates (Rust).
prepend_to_path "$HOME/.cargo/bin"

# Include the path to local programs (used e.g. by pip).
prepend_to_path "$HOME/.local/bin"

# Include the home bin.
prepend_to_path "$HOME/bin"

#------------------------------------------------------------------------------
# Prompt.
#------------------------------------------------------------------------------

if [ "$BASH" ]; then
	if [ "$(id -u)" -eq 0 ]; then
		# Root prompt is red.
		PROMPT_COLOR='0;31m'
		PROMPT_SYMBOL='#'
	else
		# Normal prompt is blue.
		PROMPT_COLOR='1;34m'
		PROMPT_SYMBOL='$'
	fi
	PS1="\[\033[$PROMPT_COLOR\]\A \u@\h \W \[\033[0m\]"
	# When we are in GNU screen, insert '(screen)' in between ']' and '$'.
	if [ ! -z "$STY" ]; then
		PS1+='\[\033[1;33m(screen)\033[0m\] '
	fi
	PS1+="\[\033[$PROMPT_COLOR\]$PROMPT_SYMBOL\[\033[0m\] "
else
	if [ "$(id -u)" -eq 0 ]; then
		PS1='# '
	else
		PS1='$ '
	fi
fi
export PS1

# Whenever the prompt is displayed, write the previous line to .bash_history.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#------------------------------------------------------------------------------
# Shell options.
#------------------------------------------------------------------------------

# Allow typing just 'dir' instead of 'cd dir'.
shopt -s autocd

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

# tmuxinator
if [[ -f ~/.tmuxinator-completion.bash ]]; then
	source ~/.tmuxinator-completion.bash
fi

# pacman
pacman_completion() {
	cur=$(_get_cword)
	COMPREPLY=($(pacman -Sl | cut -d " " -f 2 | grep "^$cur" 2> /dev/null))
	return 0
}
complete -F pacman_completion paci
complete -F pacman_completion pacr
complete -F pacman_completion pacp
complete -F pacman_completion pacs

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
export GREP_COLOR='1;33'
# GREP_OPTIONS is deprecated, so we use aliases.
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

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
export EDITOR=vim
export VISUAL="$EDITOR"

# History.
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT='%d/%m/%y-%H:%M:%S '
export HISTIGNORE='c:l:cd *'
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

# Fix the displayed channels in kmix.
export KMIX_PULSEAUDIO_DISABLE=1

# Make ls, du, df and possibly other programs report sizes in a human-readable
# way by default (e.g. `df` implicitly becomes `df -h`).
export BLOCKSIZE=human-readable

# Graphics.
export MESA_GLX_FX=fullscreen

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
alias ds='du -hs'
alias dsa='du -h --all --max-depth=1 --one-file-system 2> /dev/null | sort -h'
alias e='egrep'
alias er='egrep -rI'
alias fer='echo "nameserver 8.8.8.8" > /etc/resolv.conf'
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
alias vim='vim -p'
alias v='vim'
alias vd='vimdiff'
alias gvim='gvim -p'
alias gv='gvim'
alias gvd='gvimdiff'
# A git commit browser in Vim (https://github.com/junegunn/gv.vim).
function GV() { vim -c ":GV $*" -c ":+tabclose"; }
alias m='make'
function M() { make "$@" && make install; }
alias news='newsboat -q'
if [ "$(id -u)" -eq 0 ]; then
	alias mntd='mount /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk && chown root:disk /mnt/disk && chmod 0770 /mnt/disk'
else
	alias mntd='sudo mount -o gid=disk,dmask=007,fmask=117 /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk'
fi
alias umntd='sudo umount /mnt/disk'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias g='git'
alias gd='g d'
alias gl='g l'
alias gp='g p'
alias gs='g s'
alias gu='g u'
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
alias yt='youtube-dl --no-part'

# Translation. It uses https://github.com/soimort/translate-shell, which has to
# be available in $PATH under name 'trs'.
alias toen='trs cs:en'
alias tocs='trs en:cs'

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
# Usage: gvim `grep -r PATTERN | files`
function files() { cut -d: -f1 | sort -u; }

# Opens files found by recursive egrep in vim.
# Usage: ver PATTERN
function ver() { v $(er "$@" | files); }

# Conversions.
alias HEX="ruby -e 'printf(\"0x%X\n\", ARGV[0])'"
alias DEC="ruby -e 'printf(\"%d\n\", ARGV[0])'"
alias BIN="ruby -e 'printf(\"%bb\n\", ARGV[0])'"

# Pacman/yaourt aliases.
if command -v yaourt &> /dev/null; then
	alias paci='yaourt -S'   # Install
	alias pacr='yaourt -R'   # Remove
	alias pacp='yaourt -Rns' # Purge
	alias pacs='yaourt -Ss'  # Search
	alias pacu='yaourt -Syu' # Upgrade
else
	alias paci='pacman -S'   # Install
	alias pacr='pacman -R'   # Remove
	alias pacp='pacman -Rns' # Purge
	alias pacs='pacman -Ss'  # Search
	alias pacu='pacman -Syu' # Upgrade
fi

# Aptitude aliases.
alias apti='aptitude install'
alias apts='aptitude search'
alias aptr='aptitude remove'
alias aptp='aptitude purge'
alias aptu='aptitude update && aptitude upgrade'

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
# Import local settings.
#------------------------------------------------------------------------------

if [[ -f ~/.bashrc.local ]]; then
	source ~/.bashrc.local
fi

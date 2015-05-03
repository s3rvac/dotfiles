#------------------------------------------------------------------------------
# File: $HOME/.bashrc
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
prepend_to_path() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="$1:$PATH"
	fi
}

# Include a path to ruby gems.
prepend_to_path "$(ruby -rubygems -e 'puts Gem.user_dir')/bin"

# Include the user's private bin.
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
	if [ ! -z $STY ]; then
		PS1+='\[\033[1;33m (screen)\033[0m\] '
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

# Whenever displaying the prompt, write the previous line to .bash_history.
PROMPT_COMMAND='history -a'

#------------------------------------------------------------------------------
# Bash options.
#------------------------------------------------------------------------------

set -o notify

#------------------------------------------------------------------------------
# Bash shopts.
#------------------------------------------------------------------------------

shopt -s extglob
shopt -s progcomp
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s cmdhist
shopt -s lithist
# shopt -s cdspell
shopt -s no_empty_cmd_completion
shopt -s checkhash
shopt -s hostcomplete
shopt -s globstar

#------------------------------------------------------------------------------
# Completion.
#------------------------------------------------------------------------------

complete -A alias         alias unalias
complete -A command       which
complete -A export        export printenv
complete -A hostname      ssh telnet ftp ncftp ping dig nmap
complete -A helptopic     help
complete -A job -P '%'    fg jobs
complete -A setopt        set
complete -A shopt         shopt
complete -A signal        kill killall
complete -A user          su userdel passwd
complete -A group         groupdel groupmod newgrp
complete -A directory     cd rmdir

# If available, source the global bash completion file.
# See http://www.caliban.org/bash/index.shtml#completion for details.
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

complete -f -X '!*.@(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG|xcf|bmp|BMP|pcx|PCX)' gimp
complete -f -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|QT|wmv|WMV|mp3|MP3|ogg|OGG|ogm|OGM|ogv|OGV|mp4|MP4|wav|WAV|asx|ASX|mng|MNG|m4v|mkv)' mplayer
complete -f -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|QT|wmv|WMV|mp3|MP3|ogg|OGG|ogm|OGM|ogv|OGV|mp4|MP4|wav|WAV|asx|ASX|mng|MNG|m4v|mkv)' mpv

# If available, source the Git completion file.
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
# Autocomplete for 'g' (git) as well.
complete -o default -o nospace -F _git g

#------------------------------------------------------------------------------
# Colors.
#------------------------------------------------------------------------------

# ls
eval $(dircolors)
LS_COLORS="$LS_COLORS*.JPG=01;35:*.GIF=01;35:*.jpeg=01;35:*.pcx=01;35:*.png=01;35:*.pnm=01;35:*.bz2=01;31:*.mpg=01;38:*.mpeg=01;38:*.MPG=01;38:*.MPEG=01;38:*.m4v=01;038:*.mp4=01;038:*.swf=01;038:*.avi=01;38:*.AVI=01;38:*.wmv=01;38:*.WMV=01;38:*.asf=01;38:*.ASF=01;38:*.mov=01;38:*.MOV=01;38:*.mp3=01;39:*.ogg=01;39:*.MP3=01;39:*.Mp3=01;39"
export LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS'

# grep
export GREP_COLOR="1;33"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# gcc (available since gcc 4.9)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#------------------------------------------------------------------------------
# Typos.
#------------------------------------------------------------------------------

alias maek=make
alias meak=make
alias meka=make
alias mkae=make
alias mkea=make

#------------------------------------------------------------------------------
# Miscellaneous.
#------------------------------------------------------------------------------

ulimit -c 0                # Disable core files generation.
eval $(lesspipe.sh)        # Allow less to view *.gz etc. files.
set -o vi                  # Enable vi-like motion when typing commands.
umask 022

#------------------------------------------------------------------------------
# Environment variables.
#------------------------------------------------------------------------------

export EDITOR=vim
export VISUAL=vim
export NNTPSERVER=localhost
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%m/%d/%y-%H:%M:%S "
# Ignoring an item from the history means that it cannot be recalled by any
# means; not even with the up and down arrows. Therefore, do not ignore
# anything.
export HISTIGNORE=
export MESA_GLX_FX=fullscreen
export VIMRUNTIME=/usr/share/vim/vim74
export VIM=/usr/share/vim74
export PAGER=less
export LESS=ir
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export CONCURRENCY_LEVEL=8
export RTF2LATEX2E_DIR=/usr/share/rtf2latex2e
export VIDEO_FORMAT=PAL # Fixes the annoying spumux error in DeVeDe.
export KMIX_PULSEAUDIO_DISABLE=1 # Fixes the displayed channels in kmix.

#------------------------------------------------------------------------------
# Terminal settings.
#------------------------------------------------------------------------------

# Disable flow control (Ctrl-S,Ctrl-Q) because I use the C-S shortcut in Vim.
stty -ixon 2> /dev/null

#------------------------------------------------------------------------------
# Useful aliases to save some typing.
#------------------------------------------------------------------------------

alias c='clear'
alias l='ls -lA'
alias md='mkdir'
function mdc() { mkdir -p "$@" && eval cd "\"\$$#\""; }
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ds='du -h -s'
alias mc='LANG=en_US mc -c'
alias vim='vim -p'
alias v='vim'
alias vd='vimdiff'
alias gvim='gvim -p'
alias gv='gvim'
alias gvd='gvimdiff'
alias m='make'
alias svnst='svn st'
alias svnlog='svn log -v | less'
alias p='~/Scripts/passwords.sh'
alias more='less'
if [ "$(id -u)" -eq 0 ]; then
	alias mntd='mount /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk && chown root:disk /mnt/disk && chmod 0770 /mnt/disk'
else
	alias mntd='sudo mount -o gid=disk,dmask=007,fmask=117 /dev/"`dmesg | grep -o "\\[[a-z1-9]*\\]" | tail -n 1 | tr -d []`"1 /mnt/disk'
fi
alias umntd='sudo umount /mnt/disk'
alias my='mysql -p'
alias pi='ping google.com'
alias g='git'
alias py='python'
alias py2='python2'
alias py3='python3'
alias ri='ri --format=ansi'
alias smem='sync && echo mem > /sys/power/state'
alias Time='/usr/bin/time -v'
alias unzipa='for f in *.zip; do unzip "$f" && rm -f "$f"; done'
alias unrara='for f in *.rar; do unrar x "$f" && rm -f "$f"; done'
function zipf() { zip "$1".zip "$1" > /dev/null; echo "$1".zip; }
function zipd() { zip -r "$1".zip "$1"; echo""; echo "$1".zip; }
function bak() { cp "$1" "$1".bak; }
function gdbc() { gdb -ex run --args $@; }
function files() { cut -d: -f1 | sort -u; } # Usage: gvim `grep -r PATTERN | files`
function csyntax() {
	gcc -std=c11 -fsyntax-only "$1" 2>&1 | grep "error:"
}

# Conversions.
alias HEX="ruby -e 'printf(\"0x%X\n\", ARGV[0])'"
alias DEC="ruby -e 'printf(\"%d\n\", ARGV[0])'"
alias BIN="ruby -e 'printf(\"%bb\n\", ARGV[0])'"
alias WORD="ruby -e 'printf(\"0x%04X\n\", ARGV[0])'"

# Pacman aliases.
alias pacu="pacman -Syu" # Upgrade
alias paci="pacman -S"   # Install
alias pacr="pacman -R"   # Remove
alias pacp="pacman -Rns" # Purge
alias pacs="pacman -Ss"  # Search
alias pacn="pacman -Si"  # Info about the selected package
# List all installed packages
alias pacl='LIST=$(pacman -Sl); for ARG in $(pacman -Qq); do echo "$LIST" | grep " $ARG "; done'

# Paktahn aliases.
# alias pacu="pacman -Syu" # Upgrade
# alias pacua="pak -Su --aur" # Upgrade AUR
# alias paci="pak -S"   # Install
# alias pacr="pak -R"   # Remove
# alias pacp="pacman -Rns" # Purge
# alias pacs="pak"  # Search
# alias pacn="pacman -Si"  # Info about the selected package

# Aptitude aliases.
alias apti="aptitude install"
alias apts="aptitude search"
alias aptr="aptitude remove"
alias aptp="aptitude purge"
alias aptu="aptitude update && aptitude upgrade"

# Deflates the given file/contents, like a Git object.
alias deflate="perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'"

#------------------------------------------------------------------------------
# RVM (Ruby Version Manager).
#------------------------------------------------------------------------------

if [[ -s /usr/local/rvm/scripts/rvm ]]; then
	source /usr/local/rvm/scripts/rvm
fi

if [[ -r /usr/local/rvm/scripts/completion ]]; then
	source /usr/local/rvm/scripts/completion
fi

#------------------------------------------------------------------------------
# Import local settings.
#------------------------------------------------------------------------------

if [ -e ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

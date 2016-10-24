# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

RS="\033[0m" # reset
HC="\033[1m" # hicolor
UL="\033[4m" # underline
INV="\033[7m" # inverse background and foreground
FBLK="\033[30m" # foreground black
FRED="\033[31m" # foreground red
FGRN="\033[32m" # foreground green
FYEL="\033[33m" # foreground yellow
FBLE="\033[34m" # foreground blue
FMAG="\033[35m" # foreground magenta
FCYN="\033[36m" # foreground cyan
FWHT="\033[37m" # foreground white
BBLK="\033[40m" # background black
BRED="\033[41m" # background red
BGRN="\033[42m" # background green
BYEL="\033[43m" # background yellow
BBLE="\033[44m" # background blue
BMAG="\033[45m" # background magenta
BCYN="\033[46m" # background cyan
BWHT="\033[47m" # background white

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#PS1="$HC$BBLE$HC$FWHT\t$HC$BYEL \u@$HC$BGRN\h$RS $HC$FWHT\W: \\\$ $RS"
PS1="$HC$FBLE\t$HC$FYEL \u@$HC$FGRN\h$RS $HC$FWHT\W: \\\$ $RS"

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

# Custom function to merge mkdir and cd into one command
function mkcd() {
  [ -n "$1" ] && mkdir -p "$@" && cd "$1";
}

# Show pwd after dir/dirr
function dir(){
  ls -alh;
  printf "   %b%b%b\n" "$INV" "$PWD" "$RS";
}
function dirr(){
  ls -ahltr;
  printf "   %b%b%b\n" "$INV" "$PWD" "$RS";
}
function dl(){
  dir|less -R;
 }

function up (){
  local arg=${1:-1};
  while [ $arg -gt 0 ]; do
    cd .. >&/dev/null && dir;
    arg=$(($arg - 1));
  done
}

# Print working directory after a cd.
cd() {
    if [[ $@ == '-' ]]; then
        builtin cd "$@" && dir > /dev/null  # We'll handle pwd.
    else
        builtin cd "$@" && dir
    fi
}
alias acs='apt-cache search'
alias aps='aptitude show'
alias cdinc='cd /home/dayo/Documents/inc/'
alias cmu='cd /home/dayo/owncloud/cmu'
alias cvl='cd /var/log'
alias d750='find . -type d -exec chmod 750 {} +'
alias dfa='df -ah'
alias dlr='dirr | less'
alias eb='exec bash'
alias f640='find . -type f -exec chmod 640 {} +'
alias git80='git log | fmt --width=80|less'
alias ll='last | less'
alias mpdk='mpd --kill'
alias mus='cd ~/Music'
alias ncmp='ncmpcpp -h localhost -p 6600'
alias ogg2mp3='for f in *.ogg; do avconv -i "$f" -c:a libmp3lame -q:a 2 "${f/ogg/mp3}"; done'
alias pag='ps aux|grep'
alias pj='cd /home/dayo/Documents/projects'
alias rpw='egrep -ioam1 '[a-z0-9]{8}' /dev/urandom'
alias sai='sudo aptitude install'
alias sasu='sudo aptitude safe-upgrade'
alias sau='sudo aptitude update'
alias sb='sudo bash'
alias sob='source ~/.bashrc'
alias tcz='tar cvzf'
alias tat='tmux attach -t'
alias tls='tmux list-sessions'
#alias tnc='tmux new-session -s n vim\; new-window -n sasu\; new-window -n emerge\; new-window -n root\; new-window'
alias tnc='tmux new-session -s c -n sasu'
alias tns='tmux new-session -s'
alias txz='tar xvzf'
alias vids='cd ~/Documents/inc/vids'
alias wgc='wget -c'
alias ydc='/usr/local/bin/youtube-dl -c'
alias ydx='/usr/local/bin/youtube-dl -cx --audio-format mp3'
export EDITOR='vim'

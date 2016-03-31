script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

# set PATH so it includes user's private bin
PATH="$HOME/bin:$PATH"

# Load host-specific commands
host_specific="$dotfile_dir/hosts/$HOSTNAME.sh"
if [ -f $host_specific ]; then
    . $host_specific
fi

# Provides ___git_ps1 function (as distinct from __git_ps1 function
# present by default on some hosts) to do git status in prompt
source "$dotfile_dir/git-prompt.sh"

# Autocomplete ssh hostnames using .ssh/config
source "$dotfile_dir/ssh_host_autocomplete.sh"

function title {
  echo -ne "\033];$*\007"
}

function default_title {
  title "$USER@$HOSTNAME"
}

function update_dotfiles {
  if [[ $EUID -ne 0 ]]; then
    echo "Updating dotfiles..."
    pushd $dotfile_dir > /dev/null
    git pull origin master
    ./link_dotfiles.sh
    popd > /dev/null
  fi
}

alias df="df -h"
alias dfi="df -ih"

#Colors using tput (so the vars contain the actual control characters)
if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
  MAGENTA=$(tput setaf 9)
  ORANGE=$(tput setaf 172)
  GREEN=$(tput setaf 190)
  PURPLE=$(tput setaf 141)
  WHITE=$(tput setaf 256)
else
  MAGENTA=$(tput setaf 5)
  ORANGE=$(tput setaf 4)
  GREEN=$(tput setaf 2)
  PURPLE=$(tput setaf 1)
  WHITE=$(tput setaf 7)
fi
RED=$(tput setaf 1)
BOLD=$(tput bold)
RESET=$(tput sgr0)

if [[ $EUID -eq 0 ]]; then
  echo -e "$RED!!! ROOT SHELL !!!$RESET"
fi

#Debian-specific commands
if  grep -qs "Debian" /etc/issue; then
    # set variable identifying the chroot you work in
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
fi

#Set colors for various filetypes
eval `dircolors -b $dotfile_dir/dircolors.ansi-dark`

alias ls="ls --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"

export EDITOR=vim

# Options for ___git_ps1
export GIT_PS1_SHOWUPSTREAM="autoZZ"
export GIT_PS1_SHOWCOLORHINTS="yes"
export GIT_PS1_SHOWDIRTYSTATE="yes"

# root gets a different username and prompt
if [[ $EUID -eq 0 ]]; then
  prompt_user=$RED"ROOT"$RESET
  prompt="###"
else
  prompt_user=$USER
  prompt='\$'
fi

# Set the custom prompt. Needs to happen before iTerm2 shell integration or it won't stick
PS1=$prompt_user'@\['$ORANGE'\]\h\['$RESET'\]:\w\a$(___git_ps1 " (%s)")'$prompt' '

PROMPT_COMMAND="default_title"

# iTerm2 shell integration
#if [[ $- == *i* ]]; then
source "$dotfile_dir/iterm2_shell_integration.`basename $SHELL`"
#fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

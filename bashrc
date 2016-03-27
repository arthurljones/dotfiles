script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

. "$dotfile_dir/git-prompt.sh"
. "$dotfile_dir/ssh_host_autocomplete.sh"
. "$dotfile_dir/shell_colors.sh"

if  grep -qs "Debian" /etc/issue; then
    is_debian="true"
fi

if uname | grep -qs "Darwin"; then
    is_darwin="true"
fi

if [[ $EUID -eq 0 ]]; then
    echo -e "$COLOR_RED!!! ROOT SHELL !!!$COLOR_RESET"
    is_root="true"
fi

if [ -n "$is_debian" ]; then
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

# Show git status in prompt
export GIT_PS1_SHOWUPSTREAM="autoZZ"
export GIT_PS1_SHOWCOLORHINTS="yes"
export GIT_PS1_SHOWDIRTYSTATE="yes"

if [ -n "$is_root" ]; then
    PROMPT_COMMAND='___git_ps1 "\[$COLOR_RED\]ROOT\[$COLOR_RESET\]@\[$COLOR_PURPLE\]\h\[$COLOR_RESET\]:\w\a" " ### "'
else
    PROMPT_COMMAND='___git_ps1 "\u@\[$COLOR_PURPLE\]\h\[$COLOR_RESET\]:\w\a" " \$ "'
fi

# set PATH so it includes user's private bin
PATH="$HOME/bin:$PATH"

# Load host-specific commands
host_specific="$dotfile_dir/hosts/$HOSTNAME.sh"
if [ -f $host_specific ]; then
    . $host_specific
fi

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

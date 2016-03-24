echo "Loading .bashrc"

dotfile_dir="$HOME/dotfiles"

source "$dotfile_dir/git-prompt.sh"
source "$dotfile_dir/ssh_host_autocomplete.sh"
source "$dotfile_dir/shell_colors.sh"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx #BSD/OSX
export LS_COLORS=$LSCOLORS #Linux
export LS_OPTIONS='--color=auto'
export EDITOR=vim

# Show git status in prompt
export GIT_PS1_SHOWUPSTREAM="autoZZ"
export GIT_PS1_SHOWCOLORHINTS="yes"
command_prefix="\u@$COLOR_BROWN\h$COLOR_RESET:\w\a"
command_suffix="$COLOR_BOLD_WHITE\\\$$COLOR_RESET "
export PROMPT_COMMAND='__git_ps1 "$command_prefix" "$command_suffix";'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Load host-specific commands
host_specific="$dotfiles/hosts/$HOSTNAME"
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


if grep -s "Debian" /etc/issue; then
    echo "Debian system"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    # Color prompt
    force_color_prompt=yes

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

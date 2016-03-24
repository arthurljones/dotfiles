echo "Loading .bashrc in $dotfile_dir"

dotfile_dir="$HOME/dotfiles"

source "$dotfile_dir/git-prompt"
source "$dotfile_dir/ssh_host_autocomplete"
source "$dotfile_dir/shell_colors"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=vim
export GIT_PS1_SHOWUPSTREAM="autoZZ"
export GIT_PS1_SHOWCOLORHINTS="yes"
export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ ";'

case $HOSTNAME in
aj-mbp)
    export SENCHA_CMD_3_0_0="/Users/aj/bin/Sencha/Cmd/6.0.2.14"
    export ANDROID_SDK_HOME=/Users/aj/workspace/lib/android-sdk
    export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"
    export PATH="/Users/aj/bin/Sencha/Cmd/6.0.2.14/..:$PATH"
    export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    ;;
esac

#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

append_to_path() {
    #[[ -d $1 && ! ":$PATH:" == *"$1"* ]] && 
    PATH="$PATH:$1"
    export PATH
    #echo "appended $1 to PATH"
    #echo $PATH
}

prepend_to_path() {
    #[[ -d $1 && ! ":$PATH:" == *"$1"* ]] && 
    PATH="$1:$PATH"
    export PATH
    #echo "prepended $1 to PATH"
    #echo $PATH
}

export TZ='America/Los_Angeles'
export PATH=$(getconf PATH)
append_to_path "/sbin"
append_to_path "/usr/sbin"
append_to_path "/usr/local/sbin"
append_to_path "/usr/local/bin"
prepend_to_path "$HOME/bin"
prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/lib/idea/bin"
prepend_to_path "$HOME/tools"
prepend_to_path "/usr/local/opt/coreutils/libexec/gnubin"
prepend_to_path "$HOME/.npm-global/bin"
prepend_to_path "$HOME/lib/Android/Sdk/platform-tools"
prepend_to_path "$HOME/opt/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin"

# Load host-specific commands
host_specific="$dotfile_dir/hosts/$HOSTNAME.sh"
if [ -f $host_specific ]; then
  source $host_specific
fi

# For android studio
export _JAVA_AWT_WM_NONREPARENTING=1

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export ANDROID_HOME="$HOME/lib/Android/Sdk"

# Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ruby Version Manager (rvm)
export rvmsudo_secure_path=0
[[ -s "$HOME/.rvm/bin" ]] && append_to_path "$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function update_dotfiles {
  if [[ $EUID -ne 0 ]]; then
    echo "Updating dotfiles..."
    pushd $dotfile_dir > /dev/null
    git pull origin master
    git submodule update --init --recursive
    ./link_dotfiles.sh
    popd > /dev/null
    source $dotfile_dir/bashrc
  fi
}

if [[ $- == *i* ]]; then
  source "$dotfile_dir/bashrc_interactive"
fi

export PICOTOOL_FETCH_FROM_GIT_PATH=/home/aj/pico/picotool
export PICO_EXAMPLES_PATH=/home/aj/pico/pico-examples
export PICO_EXTRAS_PATH=/home/aj/pico/pico-extras
export PICO_PLAYGROUND_PATH=/home/aj/pico/pico-playground
export PICO_SDK_PATH=/home/aj/pico/pico-sdk


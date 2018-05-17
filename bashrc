#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

append_to_path() {
    [[ -d $1 ]] && PATH="$PATH:$1"
    export PATH
}

prepend_to_path() {
    [[ -d $1 ]] && PATH="$1:$PATH"
    export PATH
}

append_to_path "/sbin"
append_to_path "/usr/sbin"
append_to_path "/usr/local/sbin"
prepend_to_path "$HOME/bin"
prepend_to_path "$HOME/tools"
prepend_to_path "$HOME/Qt5.5.1/5.5/clang_64/bin"
prepend_to_path "/usr/local/opt/coreutils/libexec/gnubin"
prepend_to_path "$HOME/.npm-global/bin"
prepend_to_path "$HOME/Library/Python/2.7/bin"
prepend_to_path "/opt/wavebox"

# Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ruby Version Manager (rvm)
export rvmsudo_secure_path=0
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

# Load host-specific commands
host_specific="$dotfile_dir/hosts/$HOSTNAME.sh"
if [ -f $host_specific ]; then
  source $host_specific
fi

if [[ $- == *i* ]]; then
  source "$dotfile_dir/bashrc_interactive"
fi


#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/tools" ]] && PATH="$HOME/tools:$PATH"
[[ -d $HOME/Qt5.5.1/5.5/clang_64/bin ]] && PATH="$HOME/Qt5.5.1/5.5/clang_64/bin:$PATH"
osx_gnubin="/usr/local/opt/coreutils/libexec/gnubin"
[[ -d "$osx_gnubin" ]] && PATH="$osx_gnubin:$PATH"
[[ -d $HOME/.npm-global ]] && PATH="$HOME/.npm-global/bin:$PATH"
[[ -d $HOME/Library/Python/2.7/bin ]] && PATH=$PATH:$HOME/Library/Python/2.7/bin
export PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function update_dotfiles {
  if [[ $EUID -ne 0 ]]; then
    echo "Updating dotfiles..."
    pushd $dotfile_dir > /dev/null
    git pull origin master
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

#Ruby Version Manager
export rvmsudo_secure_path=0
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting

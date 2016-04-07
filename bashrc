#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/tools" ]] && PATH="$HOME/tools:$PATH"

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
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

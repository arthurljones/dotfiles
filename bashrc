#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

# set PATH so it includes user's private bin
PATH="$HOME/bin:$PATH"

function update_dotfiles {
  if [[ $EUID -ne 0 ]]; then
    echo "Updating dotfiles..."
    pushd $dotfile_dir > /dev/null
    git pull origin master
    ./link_dotfiles.sh
    popd > /dev/null
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

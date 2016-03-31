#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

# set PATH so it includes user's private bin
PATH="$HOME/bin:$PATH"

# Load host-specific commands
host_specific="$dotfile_dir/hosts/$HOSTNAME.sh"
if [ -f $host_specific ]; then
  source $host_specific
fi

if [[ $- == *i* ]]; then
  source "$dotfile_dir/bashrc_interactive"
fi

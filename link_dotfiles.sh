#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

if [ -z $dotfile_dir ]; then
    echo "Failed to determine where dotfiles are stored"
    exit 1
fi

for dotfile in bashrc bash_profile profile vimrc; do
    src="$HOME/.$dotfile"
    dst="$dotfile_dir/$dotfile"
    if ! [[ -f src ]]; then
        ln -s $dst $src
    fi
done

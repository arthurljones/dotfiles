#!/bin/bash
dotfile_dir=${BASH_SOURCE%/*}
for dotfile in bashrc bash_profile profile vimrc; do
    src="$HOME/.$dotfile"
    dst="$dotfile_dir/$dotfile"
    if ! [[ -f src ]]; then
        ln -s $dst $src
    fi
done

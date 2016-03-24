#!/bin/bash

for dotfile in bashrc bash_profile profile vimrc; do
    src="$HOME/.$dotfile"
    dst="$HOME/dotfiles/$dotfile"
    if ! [[ -f src ]]; then
        ln -s $dst $src
    fi
done

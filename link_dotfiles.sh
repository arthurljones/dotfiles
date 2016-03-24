#!/bin/bash

for dotfile in bashrc bash_profile profile; do
    src="$HOME/$dotfile"
    dst="$HOME/dotfiles/$dotfile"
    if ! [[ -f src ]]; then
        ln -s $src $dst
    fi
done

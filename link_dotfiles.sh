#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

while [[ $# > 0 ]]; do
    key="$1"

    case $key in
        -f|--force)
            force="true"
        ;;
        *)
            echo "Unknown option $1. Usage: `basename $0` [-f|--force]"
            exit 1
        ;;
    esac
    shift # past argument or value
done

if [ -z $dotfile_dir ]; then
    echo "Failed to determine where dotfiles are stored"
    exit 1
fi

echo "Linking dotfiles..."
for dotfile in bashrc bash_profile profile vimrc; do
    src="$HOME/.$dotfile"
    dst="$dotfile_dir/$dotfile"

    if [ -n "$force" ]; then
        if [[ -f $src ]]; then
            echo "Removing $src"
            rm $src
        fi
    fi

    if [[ -f "$src" ]]; then
        echo "Not linking $src because it already exists"
    else
        echo "Linking $src -> $dst"
        ln -s $dst $src
    fi
done

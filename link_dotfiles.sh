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
for dotfile in \
    bashrc \
    bash_profile \
    profile  \
    vim  \
    vimrc  \
    gitconfig  \
    fonts  \
    xorg/xinitrc \
    xorg/xsession \
    gemrc \
    ; do
    src="$HOME/.$(basename $dotfile)"
    dst="$dotfile_dir/$dotfile"

    if [[ -h "$src" ]] && [[ "$dst" == $(readlink "$src") ]]; then
        echo "Link $src is already up to date"
        continue
    elif [[ -e "$src" ]]; then
        backup="$src.old" 
        if [[ -e "$backup" ]] && ! [[ -n "$force" ]]; then
            echo "Backup already exists at $backupc. Use --force to overwrite it"
        else
            echo "Backing up existing $src to $backup"
            mv -f "$src" "$backup"
        fi 
    fi

    if [[ -e "$src" ]]; then
        echo "Not linking $src because it already exists"
    else
        echo "Linking $src -> $dst"
        ln -s $dst $src
    fi
done

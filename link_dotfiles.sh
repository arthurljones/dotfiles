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
# Takes a path to a file relative to $dotfile_dir
link_dotfile() {
    local dotfile=$1
    local default_dst=$HOME/.$(basename $dotfile)
    local dst=${2:-$default_dst}
    local src="$dotfile_dir/$dotfile"

    if [[ "$OSTYPE" == "darwin"* && $dotfile == "xorg"* ]]; then
        echo "Skipping $dotfile on OSX"
        return
    fi

    if [[ -h "$dst" ]] && [[ "$src" == $(readlink "$dst") ]]; then
        echo "Link $dst is already up to date"
        return
    elif [[ -e "$dst" ]]; then
        backup="$dst.old" 
        if [[ -e "$backup" ]] && ! [[ -n "$force" ]]; then
            echo "Backup already exists at $backupc. Use --force to overwrite it"
        else
            echo "Backing up existing $dst to $backup"
            mv -f "$dst" "$backup"
        fi 
    fi

    if [[ -e "$dst" ]]; then
        echo "Not linking $dst because it already exists"
    else
        echo "Linking $dst -> $src"
        dst_dir=$(dirname $dst)
        mkdir -p $dst_dir
        ln -s $src $dst
    fi
}

link_dotfile xorg/awesome/rc.lua $HOME/.config/awesome/rc.lua 

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
    iterm2 \
    ; do
    link_dotfile $dotfile
done

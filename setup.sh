#!/bin/bash

script_path=$(realpath $BASH_SOURCE)
dotfile_dir=${script_path%/*}

$dotfile_dir/link_dotfiles.sh

echo "Updating git submodules"
pushd $dotfile_dir > /dev/null
git submodule update --init --recursive
popd > /dev/null

echo "Done"

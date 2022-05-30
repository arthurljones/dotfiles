#!/bin/bash

pushd $HOME/dotfiles/xorg

for file in setup.d/*; do
    /bin/bash "$file"
done;

./configure_input.sh

popd

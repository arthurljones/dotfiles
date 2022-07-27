#!/bin/bash

pushd $HOME/dotfiles/xorg > /dev/null

for file in script-setup.d/*; do
    echo "Running $file"
    /bin/bash "$file"
done;

popd > /dev/null

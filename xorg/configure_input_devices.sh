#!/bin/bash

xorg_conf=$HOME/dotfiles/xorg

# Remap mouse buttons (side buttons as middle click)
$xorg_conf/remap_mouse_button.sh

# Load up our custom xmodmap
xmodmap $xorg_conf/xmodmap

# Set keyboard repeat delay to 400ms and repeat rate to 100
xset r rate 400 100

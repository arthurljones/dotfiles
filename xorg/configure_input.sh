#!/bin/bash

xorg_conf=$HOME/dotfiles/xorg

# Remap mouse buttons (side buttons as middle click)
$xorg_conf/remap_mouse_button.sh

#setxkbmap -option ctrl:nocaps -option altwin:swap_alt_win

# Load up our custom xmodmap
# TODO: configure this so it works with both the built-in and kinesis keyboards
xmodmap $xorg_conf/xmodmap

# Set keyboard repeat delay to 400ms and repeat rate to 100
xset r rate 400 100

# Disable trackpoint
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0

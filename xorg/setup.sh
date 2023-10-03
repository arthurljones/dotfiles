#!/bin/bash

xorg_conf=$HOME/dotfiles/xorg

# Remap mouse buttons (side buttons as middle click)
$xorg_conf/remap_mouse_button.sh

setxkbmap -option ctrl:nocaps -option altwin:swap_alt_win

# Set keyboard repeat delay to 400ms and repeat rate to 100
xset r rate 400 100

# Disable trackpad, trackpoint and buttons
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
xinput set-prop "ThinkPad Extra Buttons" "Device Enabled" 0

# Gnome shell stuff
# Disable popup from single-pressing meta key
gsettings set org.gnome.mutter overlay-key ''



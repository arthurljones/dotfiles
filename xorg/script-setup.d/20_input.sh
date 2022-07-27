#!/bin/bash

xorg_conf=$HOME/dotfiles/xorg

# Setup HW keymappings. Need to do this first, since it
# causes all inputs to be reset
pushd $xorg_conf/udev > /dev/null
sudo ./install_hwdb.sh
popd > /dev/null

sleep 0.5

# Set keyboard repeat delay to 400ms and repeat rate to 100
xset r rate 400 100

# Disable trackpoint (disabled - thinkpad only)
#xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0

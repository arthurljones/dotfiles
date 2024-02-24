#!/bin/bash
cd $(dirname $(readlink -f $0))
source common.sh
startup


#xorg_conf=$HOME/dotfiles/xorg

log "running as $UID: $(who)"


# Disable trackpoint (disabled - thinkpad only)
#xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0

sleep 1

# Set keyboard repeat delay to 400ms and repeat rate to 100
xset r rate 400 100 2>&1

case $1 in
    ergodox_ez_add)
        log "setting us keymap"
        setxkbmap us
        ;;

    ergodox_ez_remove)
        log "setting dvorak keymap"
        setxkbmap dvorak
        ;;
esac

shutdown

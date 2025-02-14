#!/bin/bash
if [ $UID -ne 0 ]; then
    echo "$0 must be run as root"
    exit 1
fi

rm -f /etc/udev/rules.d/*-aj-*.rules
cp /home/aj/dotfiles/udev/rules/*-aj-*.rules /etc/udev/rules.d
udevadm control --reload-rules 
udevadm trigger

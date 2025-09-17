#!/bin/bash

if [ $UID -ne 0 ]; then
    echo "$0 must be run as root"
    exit 1
fi

install etc/interception/udevmon.d/50-caps2esc.yml /etc/interception/udevmon.d/
systemctl restart udevmon

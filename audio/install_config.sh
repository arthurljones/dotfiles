#!/bin/bash
scriptdir=$(dirname "$(readlink -f "$0")")
dest=/home/aj/.config/pipewire/
conf=pipewire.conf.d/
mkdir -p "$dest"
rm -rf "$dest/$conf"
cp -r "$scriptdir/$conf" "$dest"
systemctl --user restart pipewire.service pipewire-pulse.service

#!/bin/sh
internal="--output eDP-1 --auto --pos 0x665"
external=$(xrandr -q | grep " connected" | grep -v "eDP-1" | cut -d ' ' -f1 | head -n1)
if [ -z $external ]; then
    internal="$internal --primary"
else
    external="--output $external --primary --mode 3440x1440 --pos 1920x0"
fi
echo "xrandr $internal $external"
xrandr $internal $external

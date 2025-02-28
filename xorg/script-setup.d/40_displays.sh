#!/bin/sh
##internal="--output eDP-1 --auto --pos 0x0"
external=$(xrandr -q | grep " connected" | grep -v "eDP-1" | cut -d ' ' -f1 | head -n1)
if [ -z $external ]; then
    command="xrandr --auto"
else
    internal="--output eDP-1 --auto --pos 0x665"
    external="--output $external --primary --auto --pos 1920x0"
    command="xrandr $internal $external"
fi
echo "$command"
`$command`
xmonad --restart
# Disabled so the scripts don't require root
# echo 4 | sudo tee /sys/class/backlight/acpi_video0/brightness

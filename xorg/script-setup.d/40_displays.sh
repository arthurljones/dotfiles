#!/bin/sh
external=$(xrandr -q | grep " connected" | grep -v "eDP-1" | cut -d ' ' -f1 | head -n1)
xrandr --output eDP-1 --mode 1920x1080 --pos 0x665 --rotate normal --output HDMI-1 --off --output $external --primary --mode 3440x1440 --pos 1920x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off

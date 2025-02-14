#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: set_brightness.sh [number]"
    exit 1
fi
echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness

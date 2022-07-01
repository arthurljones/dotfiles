#!/bin/bash
# Use USB audio if it's available
usb_audio=$(pactl list short sinks | grep "USB_Advanced_Audio")
if [ $? -eq 0 ]; then
    echo "Using dock audio"
    device=$(echo $usb_audio | cut -d " " -f 1)
    pactl set-default-sink $device
else
    echo "Using built-in audio"
fi


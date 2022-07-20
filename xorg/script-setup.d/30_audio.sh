#!/bin/bash
# Restart pipewire to pick up new devices (this shouldn't be necessary, but
# sometimes pipewire will fail to pick up USB audio devices.
echo "Restarting pipewire and pipewire-pulse services"
systemctl --user restart pipewire.service
systemctl --user restart pipewire-pulse.service
systemctl --user daemon-reload

echo -n "Waiting for audio devices to come online"
for i in {1..20}; do
    sleep 0.1

    # Use USB audio if it's available
    usb_audio=$(pactl list short sinks | grep "USB_Advanced_Audio")
    if [ $? -eq 0 ]; then
        echo
        echo "Using dock audio"
        device=$(echo $usb_audio | cut -d " " -f 1)
        pactl set-default-sink $device
        break
    fi
    echo -n "."
done
if [ -z usb_audio ]; then 
    echo
    echo "Using built-in audio"
fi


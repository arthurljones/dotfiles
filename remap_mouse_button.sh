#!/bin/bash

if ! type xinput >/dev/null 2>&1; then
    echo "No xinput on this system, can't remap mouse"
    exit 1
fi

mouse_id=$(xinput list | grep "Logitech.*pointer" | head -n 1 |  sed 's/.*id=\([0-9]\+\).*/\1/g')

if [ -z "$mouse_id" ]; then
    echo "Couldn't find mouse ID"
    exit 1
fi

# Map button 9 (top side button) to button 2 (middle button)
xinput set-button-map $mouse_id 1 2 3 4 5 6 7 8 2 10 11 12 13 14 15 16

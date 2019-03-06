#!/bin/bash
echo "$0 `date`" >> $HOME/dotfiles/xorg/log.txt

if ! type xinput >/dev/null 2>&1; then
    echo "No xinput on this system, can't remap mouse" >&2
    exit 1
fi

if [[ -z "$DISPLAY" ]]; then
    echo "No \$DISPLAY set" >&2
    exit 1
fi

if ! xset q &>/dev/null; then
    echo "No X server at \$DISPLAY [$DISPLAY]" >&2
    exit 1
fi

mouse_id=$(xinput list | grep "Logitech.*pointer" | head -n 1 |  sed 's/.*id=\([0-9]\+\).*/\1/g')

if [ -z "$mouse_id" ]; then
    echo "Couldn't find mouse ID" >&2
    exit 1
fi

# Map buttons 8 and 9 (top side buttons) to button 2 (middle button)
xinput set-button-map $mouse_id 1 2 3 4 5 6 7 2 2 10 11 12 13 14 15 16

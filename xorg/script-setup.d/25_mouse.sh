#!/bin/bash
if ! type xinput >/dev/null 2>&1; then
    echo "No xinput on this system, can't remap mouse" >&2
    exit 1
fi

if [[ -z "$DISPLAY" ]]; then
    export DISPLAY=:0
    echo "No \$DISPLAY set, using $DISPLAY" >&2
fi

if [[ -z "$XAUTHORITY" ]]; then
    export XAUTHORITY=/home/aj/.Xauthority
    echo "No \$XAUTHORITY set, using $XAUTHORITY" >&2
fi

if ! xset q &>/dev/null; then
    echo "No X server at \$DISPLAY [$DISPLAY]" >&2
    exit 1
fi

m575_id=$(xinput list | grep "M575" | head -n 1 |  sed 's/.*id=\([0-9]\+\).*/\1/g')
m570_id=$(xinput list | grep "M570" | head -n 1 |  sed 's/.*id=\([0-9]\+\).*/\1/g')

if [ -n "$m575_id" ]; then
    echo "Setting up M575 acceleration"
    mouse_id="$m575_id"
    xinput --set-prop $mouse_id 'libinput Accel Speed' 0
    xinput --set-prop $mouse_id 'Edev scrolling distance' .5 1 1
    xinput --set-prop $mouse_id 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 .45
elif [ -n "$m570_id" ]; then
    echo "Using M570"
    mouse_id="$m570_id"
else
    echo "Couldn't find mouse ID" >&2
    exit 1
fi


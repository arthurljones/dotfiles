#!/bin/bash

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

mouse_ids=$(xinput list | egrep -i "(mouse|slave)\s+pointer" |  sed 's/.*id=\([0-9]\+\).*/\1/g')
for mouse_id in $mouse_ids; do
    # Map buttons 8 and 9 (back/forward) to button 2 (middle)
    xinput set-button-map $mouse_id 1 2 3 4 5 6 7 2 2 10 11 12 13 14 15 16
done

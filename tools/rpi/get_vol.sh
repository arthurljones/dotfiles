#!/bin/bash

output=$(amixer 2>&1)
if [[ $? -ne 0 ]]; then
    echo "N/A"
    exit
fi

IFS=' ' read max min <<< $(echo "$output" \
    | grep -e 'Limits: Playback' \
    | head -n 1 \
    | sed 's/.*\([0-9]\+\) - \([0-9]\+\).*/\1 -\2/')

mag=$(echo "$output" \
    | grep -e 'Playback.*dB\]' \
    | head -n 1 \
    | sed 's/.*\[\([-0-9.]\+\)dB\].*/\1/')

ratio=$(echo $min $max $mag \
    | awk '{ printf "%1.4f", ($1 - $3 - $2) / ($1 - $2) }' )

percent=$(echo $ratio \
    | awk '{ printf "%2.0f%", $1 * 100 }')

echo $percent

#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <key_label>"
    exit 1
fi

secrets_file="$HOME/.oath_secrets"
if ! [[ -f "$secrets_file" ]]; then
    echo "Couldn't find secrets file ($secrets_file)"
    exit 1
fi

line=$(grep "\"$1\"" $secrets_file)
if [ -z "$line" ]; then
    echo "Couldn't find secret token for \"$1\""
    exit 1
fi
remaining=$(date +%s | awk '{ print 30 - ($1 % 30) }')
key="$(echo $line | cut -d ' ' -f 2 | sed 's/\"//g')"

otp=$(oathtool --base32 --totp $key -d 6)
echo "$otp - $remaining seconds left"

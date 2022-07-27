#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

for file in /etc/udev/hwdb.d/*.hwdb; do
    rm $file
done
cp *.hwdb /etc/udev/hwdb.d/
systemd-hwdb update
udevadm trigger

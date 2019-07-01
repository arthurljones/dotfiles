#!/bin/bash
#echo "<img>/usr/share/icons/Adwaita/16x16/system-monitor.png</img>"
echo "<txt>$(cat /sys/class/thermal/thermal_zone0/temp | awk "{ printf(\"%0.1f°\", \$1 / 1000); }")</txt>"



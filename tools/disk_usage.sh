#!/bin/bash
 #Print disk usages in 1kB blocks
\df -k \
 # Drop the first two lines
| tail -n +2 \
| sed "s/\s\+/ /g" \ #Change all strings of whitespace to single spaces
| cut -d ' ' -f 2 \ #Select the second column
| awk '{s += $1} END {printf' \
'"Total disk usage: %.0f GB", s / (1024*1024)}' #Sum and print the result

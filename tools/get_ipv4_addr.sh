#!/bin/sh
#Gets a list of the system's IPv4 addresses
ifconfig | grep -P 'inet(?!6)' | grep -v '127.0' | awk '{print $2}' | sed 's/addr://' 

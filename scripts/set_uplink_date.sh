#! /bin/bash
datetime=`date -u +%Y%m%d%H%M%S | sed 's/\(.*\)\([0-6][0-9]\)/\1.\2/'`
ssh uplink "date -s $datetime"

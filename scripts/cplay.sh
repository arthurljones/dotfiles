#!/bin/bash
# This command will break if you rename it to
# something containing "cmus".

if ! pgrep cmus ; then
    terminator -e cmus
else
    cmus-remote -u
fi

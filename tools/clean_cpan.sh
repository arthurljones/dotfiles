#!/bin/bash

if ! [[ -d ".cpan" ]]; then
    echo "Run this tool in a directory that has .cpan as a subdir"
    exit 1
fi

rm -rf .cpan/build/*              \
       .cpan/sources/authors/id   \
       .cpan/cpan_sqlite_log.* 

amixer \
    | grep -e '^\s\+Front Left:' \
    | sed 's/.*\[\([-0-9.]\+\)dB\].*/\1/' \
    | awk '{printf("%2.0f%\n", (37 + $1) * (100 / 37))}'

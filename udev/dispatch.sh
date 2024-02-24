#!/bin/bash

scriptdir=$(dirname "$(readlink -f "$0")")
run_as_aj() {
    echo $1 | su aj -c "at now"
}

case $1 in
    ergodox_ez_add)
        run_as_aj "$scriptdir/keyboard.sh $1"
        ;;

    ergodox_ez_remove)
        run_as_aj "$scriptdir/keyboard.sh $1"
        ;;

    display_change)
        run_as_aj "$scriptdir/on_display_change.sh"
        ;;

    *)
        echo "$(date): $0: unknown argument $1" | tee -a /home/aj/dotfiles/udev/udev.log
        ;;
esac

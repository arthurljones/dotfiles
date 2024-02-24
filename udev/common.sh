logfile=udev.log
caller=${BASH_SOURCE[-1]}
pidfile="$0.pid"

# Turn on job control so we we don't hang udev
set -m
bg

log() {
    echo "$(date +"%Y-%m-%dT%H:%M:%S%z") $caller: $1" >> $logfile
}

# We need to provide for a pseudo-debounce mechanism here, as udev will call
# run commands once for each subdevice, which for the ergodox keyboard, is many
startup() {
    if [ -f $pidfile ]; then 
        prevpid=$(cat $pidfile)
        if ps -p $prevpid; then
            #log "Already running, bailing"
            exit 1
        fi
    fi 

    echo $BASHPID > $pidfile
    export DISPLAY=$(who | grep aj | awk -F ' ' '{print $2}')

    log "running" 
}

shutdown() {
    log "done"
    rm -f $pidfile
}

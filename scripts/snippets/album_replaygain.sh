# Created for Savant albums, needs work on albums= line for other stuff
# Creates a bunch of processes that scan tracks
albums=$(ls | grep --color=never -P -o ".*? - .*? - \d+ \K.+?(?= - .*.mp3)" | sort | uniq)
for album in $albums; do
    echo $album
    find . -name "* - * $album - *.mp3" -print0 | xargs -r0 mp3gain -a -t &
done

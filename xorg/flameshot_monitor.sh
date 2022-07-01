#!/bin/bash
# Run this script at X wm startup to automatically upload flameshot screenshots
# that have been copied to the clipboard. The image will be replaced with a URL
# to the uploaded location.

# requires s3cmd to upload to s3
# s3cmd relies on $HOME/.s3-screendrop.conf existing, which must contain two lines:
#   access_key={bucket access key}
#   secret_key={bucket secret key}
# requires xclip for putting URL into clipboard
set -u

if !( which xclip > /dev/null && which s3cmd > /dev/null ); then
    echo "Install xclip and s3cmd and try again"
    exit 1
fi

upload_screenshot() {
    bucket="s.ajones.tech"
    base_url="http://s.ajones.tech"

    str0=`date '+%d%b%y-%N'`;
    str1=$( echo "$str0" | md5sum );
    randstring="${str1:0:8}";
    fn="$randstring-$str0.png";
    url="$base_url/$fn"

    echo "filename: $fn"

    #middle click, which we can preload with the URL before it's uploaded. we can't
    #load the url into the main clipboard (ctl+v) because it contains the image data
    printf $url | xclip;

    retry=1
    while true; do
        tmpfile=$(mktemp --suffix=".png") \
            && xclip -selection clipboard -t image/png -o > "$tmpfile" \
            && file -b "$tmpfile" | grep -q "image data" \
            && cat "$tmpfile" | s3cmd put - "s3://$bucket/$fn" -c ~/.s3-screendrop.conf --mime-type="image/png" --acl-public
        result=$?
        rm -f "$tmpfile"
        if [ $result -eq 0 ]; then
            printf $url | xclip -selection clipboard;
            break
        elif [ $retry -eq 1 ]; then
            echo "Failed to upload image, trying once more after a moment"
            sleep 1
            retry=0
        else
            echo "Failed to upload image again, aborting"
            break
        fi
    done
}

echo "Starting dbus monitor"
# Start a dbus monitor that fires the upload function
# NOTE: Very brittle, we should probably snoop the 'attachScreenshotToClipboard' message instead, and scrape the bytes from that
#dbus-monitor --profile "destination='org.flameshot.Flameshot',member='attachScreenshotToClipboard'"
magicString="Capture saved to clipboard."
dbus-monitor --session "interface='org.freedesktop.Notifications',member='Notify',arg0='flameshot',arg4='$magicString'" |
    while read -r line; do
        echo "$line" | cut -f 8 | grep "$magicString" && upload_screenshot
    done

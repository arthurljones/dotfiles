#!/bin/bash
# Run this script at X wm startup to automatically upload flameshot screenshots
# that have been copied to the clipboard. The image will be replaced with a URL
# to the uploaded location.

# requires s3cmd to upload to s3
# s3cmd relies on $HOME/.s3-screendrop.conf existing, which must contain two lines:
#   access_key={bucket access key}
#   secret_key={bucket secret key}
# requires xclip for putting URL into clipboard

flameshot

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

    xclip -selection clipboard -t image/png -o | s3cmd put - "s3://$bucket/$fn" -c ~/.s3-screendrop.conf --mime-type="image/png" --acl-public
    if [ $? -eq 0 ]; then
        printf $url | xclip -selection clipboard;
    fi
}

# Start a dbus monitor that fires the upload function
dbus-monitor --profile "interface='org.flameshot.Flameshot',member='captureTaken'" |
while read -r line; do
    echo $line | grep captureTaken && upload_screenshot
done

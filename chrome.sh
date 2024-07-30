#!/usr/bin/env sh


# Script that will donwload & install Google Chrome

URL="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
DOWNLOAD_DIR="/var/tmp"
MOUNT_POINT="/Volumes/googlechrome.dmg"


# Set directory to DOWNLOAD_DIR = /var/tmp

cd "$DOWNLOAD_DIR" || { echo "Failed to change directory to $DOWNLOAD_DIR"; exit 1; }

curl -O --verbose "$URL"

if [ $? -ne 0 ];then
    echo "Failed to download $URL"
    exit 1
fi

# Mounts the Google Chrome dmg

hdiutil attach googlechrome.dmg -mountpoint $MOUNT_POINT
if [ $? -ne 0 ]; then
    echo "Failed to mount $$FILE_NAME"
    exit 1
fi

# Copies Google Chrome.app to Applications folder

 cp -R /Volumes/googlechrome.dmg/Google\ Chrome.app  /Applications
 if [ $? -ne 0 ]; then
    echo "Failed to copy Google Chrome"
else
    echo "Google Chrome copied successfully"
fi

if [ -d /Applications/Google\ Chrome.app ];then
    open /Applications/Google\ Chrome.app
else
    echo "Google Chrome does not exist"

fi

sleep 1

# Ejects the dmg

hdiutil detach $MOUNT_POINT

sleep  1

rm -rf /private/var/tmp/googlechrome.dmg 





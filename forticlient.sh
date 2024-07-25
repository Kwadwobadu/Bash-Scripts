#!/usr/bin/env bash

#Script that will install mount Forticlient DMG & Install it

# Define variables
URL="https://filestore.fortinet.com/forticlient/downloads/FortiClientVPN_OnlineInstaller.dmg"
DOWNLOAD_DIR="/var/tmp"
#FILE_NAME="FortiClientVPN_OnlineInstaller.dmg"
MOUNT_POINT="/Volumes/FortiClientVPN_OnlineInstaller"

# Change to the download directory
cd "$DOWNLOAD_DIR" || { echo "Failed to change directory to $DOWNLOAD_DIR"; exit 1; }

curl -O "$URL"
if [ $? -ne 0 ]; then
    echo "Failed to download $URL"
    exit 1
fi

hdiutil attach FortiClientVPN_OnlineInstaller.dmg -mountpoint $MOUNT_POINT
if [ $? -ne 0 ]; then
    echo "Failed to mount $$FILE_NAME"
    exit 1
fi

 cp -R /Volumes/FortiClientVPN_OnlineInstaller/FortiClientInstaller.app /var/tmp
 if [ $? -ne 0 ]; then
    echo "Failed to copy Forticlient Installer"
fi

open -g FortiClientInstaller.app

sleep 5 

hdiutil detach -force /Volumes/FortiClientVPN_OnlineInstaller

sleep 1 

rm -rf FortiClientVPN_OnlineInstaller.dmg

exit 0



#!/bin/bash

# Define variables
URL="https://cdn.zoom.us/prod/6.1.1.36333/zoomusInstallerFull.pkg"
DOWNLOAD_DIR="/var/tmp"
FILE_NAME="zoomusInstallerFull.pkg"
INSTALL_PATH="/Applications"

# Change to the download directory
cd "$DOWNLOAD_DIR" || { echo "Failed to change directory to $DOWNLOAD_DIR"; exit 1; }

# Download the Zoom installer
curl -O "$URL"
if [ $? -ne 0 ]; then
    echo "Failed to download $URL"
    exit 1
fi

# Install the Zoom package
sudo installer -pkg "$FILE_NAME" -target "$INSTALL_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to install $FILE_NAME"
    exit 1
fi

#echo "Installing"

sleep 1

# remove the installation file
rm -rf $FILE_NAME

echo "Zoom has been installed on your Mac"

exit 0

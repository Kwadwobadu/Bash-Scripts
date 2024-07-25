#!/bin/bash
# check if desktoppr is installed, install if it's not.
desktoppr="/usr/local/bin/desktoppr"
if [[ -x $desktoppr ]]; then
    echo "desktoppr found, no need to install"
else
    echo "desktoppr could not be found, installing..."
    curl -L --silent --output /tmp/desktoppr.pkg "https://github.com/scriptingosx/desktoppr/releases/download/v0.5/desktoppr-0.5-218.pkg" >/dev/null
    # install dockutil
    installer -pkg "/tmp/desktoppr.pkg" -target /
fi

sleep 7

# Check if the insaller is there, if so remove it from tmp folder 

desktoppr_file="/tmp/desktoppr.pkg"

if [[ -e $desktoppr_file ]]; then
    echo "desktoppr package removed"
    rm -rf $desktoppr_file
fi


# vars to use script and set current logged in user dock
killall="/usr/bin/killall"
loggedInUser=$( ls -l /dev/console | awk '{print $3}' )
################################################################################
# Setting Southbank Wallpaper
sudo -u $loggedInUser $desktoppr "https://drive.usercontent.google.com/download?id=11pYhin-79k-jBXFeZv_iMWqI7jkRsd_A&export=download&authuser=0"
################################################################################

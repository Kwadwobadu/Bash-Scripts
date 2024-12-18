#!/bin/bash
# check if dockutil is installed, install if it's not.
dockutil="/usr/local/bin/dockutil"
if [[ -x $dockutil ]]; then
    echo "dockutil found, no need to install"
else
    echo "dockutil could not be found, installing..."
    curl -L --silent --output /tmp/dockutil.pkg "https://github.com/kcrawford/dockutil/releases/download/3.1.3/dockutil-3.1.3.pkg" >/dev/null
    # install dockutil
    installer -pkg "/tmp/dockutil.pkg" -target /
fi
# vars to use script and set current logged in user dock
killall="/usr/bin/killall"
loggedInUser=$( ls -l /dev/console | awk '{print $3}' )
LoggedInUserHome="/Users/$loggedInUser"
UserPlist=$LoggedInUserHome/Library/Preferences/com.apple.dock.plist
################################################################################
# Use Dockutil to Modify Logged-In User's Dock
################################################################################
echo "------------------------------------------------------------------------"
echo "Current logged-in user: $loggedInUser"
echo "------------------------------------------------------------------------"
echo "Removing all Items from the Logged-In User's Dock..."
sudo -u $loggedInUser $dockutil --remove all --no-restart $UserPlist
echo "Creating New Dock..."
sudo -u $loggedInUser $dockutil --add "/System/Applications/Launchpad.app/" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/Applications/Google Chrome.app" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/Applications/Google Drive.app" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/Applications/zoom.us.app" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/Applications/Spotify.app" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/Applications/Microsoft Word.app" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "/System/Applications/System Settings.app/" --no-restart $UserPlist
sudo -u $loggedInUser $dockutil --add "~/Downloads" --section others --view auto --display folder --no-restart $UserPlist
echo "Restarting Dock..."
sudo -u $loggedInUser $killall Dock 

exit 0
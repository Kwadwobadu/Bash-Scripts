#!/bin/bash

# Function to check if Nudge is installed
check_nudge_installed() {
    if [ -d "/Applications/Utilities/Nudge.app" ] || [ -f "/Library/LaunchAgents/com.github.macadmins.Nudge.plist" ]; then
        return 0
    else
        return 1
    fi
}

# Function to remove Nudge application
remove_nudge() {
    echo "Removing Nudge application..."
    sudo rm -rf /Applications/Utilities/Nudge.app
    sudo rm -rf /Library/LaunchAgents/com.github.macadmins.Nudge.plist
    defaults delete  ~/Library/Preferences/com.github.macadmins.Nudge.plist

    if [ $? -eq 0 ]; then
        echo "Nudge application removed successfully."
    else
        echo "Failed to remove Nudge application."
        exit 1
    fi
}

# Main script execution
if check_nudge_installed; then
    remove_nudge
    echo "Nudge has been completely removed from your system."
else
    echo "Nudge is not installed on this system."
fi

exit 0

#!/usr/bin/env bash

# Script to remove Zoom on Mac

zoom_remove() {
    local ZOOM_APP="/Applications/zoom.us.app"
    local ZOOM_DAEMON_PLIST="/Library/LaunchDaemons/us.zoom.ZoomDaemon.plist"
    local ZOOM_DAEMON_TOOL="/Library/PrivilegedHelperTools/us.zoom.ZoomDaemon"
    local ZOOM_SUPPORT_DIR="$HOME/Library/Application Support/zoom.us"
    local ZOOM_PREF_PLIST="$HOME/Library/Preferences/us.zoom.xos.plist"
    
    echo "Removing Zoom application..."
    sudo rm -rf "$ZOOM_APP"
    if [ $? -eq 0 ]; then
        echo "Removed $ZOOM_APP"
    else
        echo "Failed to remove $ZOOM_APP"
    fi
    sleep 1

    echo "Removing Zoom daemon plist..."
    sudo rm -rf "$ZOOM_DAEMON_PLIST"
    if [ $? -eq 0 ]; then
        echo "Removed $ZOOM_DAEMON_PLIST"
    else
        echo "Failed to remove $ZOOM_DAEMON_PLIST"
    fi
    sleep 1

    echo "Removing Zoom daemon tool..."
    sudo rm -rf "$ZOOM_DAEMON_TOOL"
    if [ $? -eq 0 ]; then
        echo "Removed $ZOOM_DAEMON_TOOL"
    else
        echo "Failed to remove $ZOOM_DAEMON_TOOL"
    fi
    sleep 1

    echo "Removing Zoom application support directory..."
    sudo rm -rf "$ZOOM_SUPPORT_DIR"
    if [ $? -eq 0 ]; then
        echo "Removed $ZOOM_SUPPORT_DIR"
    else
        echo "Failed to remove $ZOOM_SUPPORT_DIR"
    fi
    sleep 1

    echo "Removing Zoom preference plist..."
    sudo rm -rf "$ZOOM_PREF_PLIST"
    if [ $? -eq 0 ]; then
        echo "Removed $ZOOM_PREF_PLIST"
    else
        echo "Failed to remove $ZOOM_PREF_PLIST"
    fi

    echo "Zoom has been removed successfully."
}

# Call the function
zoom_remove

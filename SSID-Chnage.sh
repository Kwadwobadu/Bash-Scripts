#!/bin/bash

# Variables
NEW_SSID="YourNetworkNameHere"  # Wi-Fi network name
NEW_PASSWORD=""  # Leave blank ("") if open network
OLD_SSID="YourNetworkNameHere"        # Optional, for forgetting

# Get Wi-Fi device name
WIFI_DEVICE=$(networksetup -listallhardwareports | \
    awk '/Wi-Fi/{getline; print $2}')

# Disconnect from current network
echo "Disconnecting from current network..."
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z

# Wait a moment for disconnect
sleep 2

# Connect to the new network
echo "Connecting to $NEW_SSID..."
networksetup -setairportnetwork "$WIFI_DEVICE" "$NEW_SSID" "$NEW_PASSWORD"

# Optional: Forget old SSID
if [ ! -z "$OLD_SSID" ]; then
  echo "Forgetting $OLD_SSID..."
  sudo networksetup -removepreferredwirelessnetwork "$WIFI_DEVICE" "$OLD_SSID"
fi

echo "Done."

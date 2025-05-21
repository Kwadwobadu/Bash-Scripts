#!/bin/bash

# SSID to forget
SSID_TO_FORGET="Your_SSID"

# Get the Wi-Fi interface name
WIFI_DEVICE=$(networksetup -listallhardwareports | \
    awk '/Wi-Fi/{getline; print $2}')

# Remove the preferred network
sudo networksetup -removepreferredwirelessnetwork "$WIFI_DEVICE" "$SSID_TO_FORGET"

echo "Removed SSID '$SSID_TO_FORGET' from preferred networks on interface '$WIFI_DEVICE'."

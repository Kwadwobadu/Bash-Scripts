#!/bin/bash

#        The Script will ask you to enter the                             #
#        model type: (MBA - MacBook Air | MBP - MacBook Pro - MBP)        #
#        once entered, it will ask for the asset tag number               #
#        from there, it will communicate with Jamf API and                #
#        update the Computer Name                                         #

JAMF_BINARY="/usr/local/jamf/bin/jamf"

# Prompt user to enter the Device Type
echo "Enter Device Type (MBA, MBP or MM):"
read device_type

# Validate the Device Type
if [[ "$device_type" != "MBA" && "$device_type" != "MBP" && "$device_type" != "MM" ]]; then
  echo "Invalid Device Type. Please enter the device type MBA, MBP or MM."
  exit 1
fi

# Prompt user to enter the Asset Number
echo "Enter Asset Number:"
read asset_number

# Validate the Asset Number (simple check, assuming it should not be empty)
if [[ -z "$asset_number" ]]; then
  echo "Asset Number cannot be empty."
  exit 1
fi

# Combine Device Type and Asset Number to set the Computer Name
computer_name="${device_type}${asset_number}"

# Set the Computer Name (macOS example)
sudo scutil --set ComputerName "$computer_name"
sudo scutil --set HostName "$computer_name"
sudo scutil --set LocalHostName "$computer_name"

echo "Device Name set to: " $computer_name

echo "Sending device name to Jamf"

# Send Information to Jamf
sudo $JAMF_BINARY recon

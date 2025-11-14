#!/usr/bin/env bash
set -eu

# ChangeNameV3.sh
# - Adds IMC (iMac) device type support
# - Accepts case-insensitive device type input (MBA, MBP, MM, IMC)
# - Removes AUTO detection per request
# - If not run as root, tries to re-exec itself with sudo
# - Sets ComputerName, HostName, LocalHostName and runs jamf recon (if jamf exists)

JAMF_BINARY="/usr/local/jamf/bin/jamf"

# Relaunch with sudo if not root
if [ "$EUID" -ne 0 ]; then
  if command -v sudo >/dev/null 2>&1; then
    echo "Not running as root — relaunching with sudo..."
    exec sudo bash "$0" "$@"
  else
    echo "This script must be run as root and sudo is not available. Exiting."
    exit 1
  fi
fi

# Helper: trim leading/trailing whitespace
_trim() { echo "$1" | awk '{$1=$1; print}'; }

# Ask for device type (no AUTO)
echo "Enter Device Type (MBA, MBP, MM, IMC):"
read -r device_type_raw
device_type_raw=$(_trim "$device_type_raw")

# Uppercase in a way compatible with older bash
device_type=$(echo "$device_type_raw" | tr '[:lower:]' '[:upper:]')

# Normalize common variants (e.g., IMAC => IMC)
case "$device_type" in
  IMAC|IMAC*) device_type="IMC" ;;
esac

# Validate device type
if [ "$device_type" != "MBA" ] && [ "$device_type" != "MBP" ] && [ "$device_type" != "MM" ] && [ "$device_type" != "IMC" ]; then
  echo "Invalid Device Type. Please enter one of: MBA, MBP, MM, IMC."
  exit 1
fi

# Prompt for Asset Number
echo "Enter Asset Number (no spaces):"
read -r asset_number_raw
asset_number=$(_trim "$asset_number_raw")

if [ -z "$asset_number" ]; then
  echo "Asset Number cannot be empty."
  exit 1
fi

# Remove any whitespace from asset number
asset_number=$(echo "$asset_number" | tr -d '[:space:]')

computer_name="${device_type}${asset_number}"

# Apply the names (we're running as root)
scutil --set ComputerName "$computer_name"
scutil --set HostName "$computer_name"
scutil --set LocalHostName "$computer_name"

echo "Device Name set to: $computer_name"

# Run jamf recon if jamf exists
if [ -x "$JAMF_BINARY" ]; then
  echo "Sending device name to Jamf via recon..."
  "$JAMF_BINARY" recon
elif command -v jamf >/dev/null 2>&1; then
  echo "Found jamf in PATH, running: jamf recon"
  jamf recon
else
  echo "Jamf binary not found at $JAMF_BINARY and not in PATH. Skipping jamf recon."
fi

exit 0

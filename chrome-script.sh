#!/bin/bash

##########################################################################################################
# This script will fully remove Google Chrome from MacOs systems, including user data,                   #
# then download and reinstall the latest version of Google Chrome Enterprise.                            #
##########################################################################################################



function quit_chrome() {
osascript -e 'quit app "Google Chrome"'
sleep 2
}

# Delete Chrome application
function remove_chrome_app() {

if [ -d "/Applications/Google Chrome.app" ]; then
    sudo rm -rf "/Applications/Google Chrome.app"
    echo "Deleted Google Chrome application."
else
    echo "Google Chrome application not found."
fi
}

# Remove Chrome user data
function remove_chrome_data() {

if [ -d "$HOME/Library/Application Support/Google/Chrome" ]; then
    sudo rm -rf "$HOME/Library/Application Support/Google/Chrome"
    echo "Removed Chrome user data."
else
    echo "No Chrome user data found."
fi 
}

function download_chrome_installer() {
    # Download the latest Google Chrome Enterprise installer
    curl -o "${HOME}"/Downloads/GoogleChrome.pkg https://dl.google.com/dl/chrome/mac/universal/stable/gcem/GoogleChrome.pkg
    echo "Downloaded Google Chrome installer."
}

function install_chrome() {
    # Install Google Chrome and clean up
    sudo installer -pkg "${HOME}"/Downloads/GoogleChrome.pkg -target /
    echo "Installed Google Chrome."
    sleep 3

    # Clean up installer
    rm "${HOME}"/Downloads/GoogleChrome.pkg
    echo "Cleaned up installer."
}

function reopen_chrome() {
    osascript -e 'tell application "Google Chrome" to activate'
    echo "Reopened Google Chrome."
}

# Main function to orchestrate the Chrome removal process
function main() {
    quit_chrome
    remove_chrome_app
    remove_chrome_data
    echo "Google Chrome removal process completed."
    echo "Proceeding to download and reinstall the latest version of Google Chrome."
    sleep 3 
    download_chrome_installer
    install_chrome
    reopen_chrome
}

main

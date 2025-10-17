#!/bin/bash


######################################################################################################
# This script will notify the user that Chrome will close in 5 seconds, then close and reopen Chrome.#
# Utilizes osascript for notifications and app control.                                              #
######################################################################################################
    
# Function to display notifications and manage Chrome restart
notify_timer() {
    for i in {5..1}; do
        osascript -e "display notification \"Chrome will close in $i seconds\" with title \"Chrome Restart\""
        sleep 1
    done
}

# Function to quit and reopen Chrome
close_chrome() {
    osascript -e 'quit app "Google Chrome"'
    sleep 2
}

# Function to reopen Chrome
reopen_chrome() {
    osascript -e 'tell application "Google Chrome" to activate'
}

# Function to notify that Chrome has reopened
notify_reopened() {
    osascript -e 'display notification "Chrome has reopened." with title "Google Chrome"'
}

# Main script execution
main() {
    notify_timer
    close_chrome
    reopen_chrome
    notify_reopened
}

main

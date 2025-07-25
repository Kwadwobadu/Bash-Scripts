#!/bin/bash
# filepath: untitled:Untitled-2


##########################################################################################
# This script kills all instances of Google Chrome on a macOS system. Sole reason is to  #
# ensure that Chrome is not running before performing any updates or checks.             #
##########################################################################################

# Find the PID(s) of Google Chrome
pids=$(pgrep "Google Chrome")

if [ -z "$pids" ]; then
    echo "Google Chrome is not running."
else
    echo "Killing Google Chrome (PID(s): $pids)"
    kill -9 $pids
fi

sleep 2 

open "/Applications/Google Chrome.app"
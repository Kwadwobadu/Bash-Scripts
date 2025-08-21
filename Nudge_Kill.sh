#!/bin/bash
# filepath: untitled:Untitled-2


# This script will find all instances of Nudge proceess & it will kill the process using arg -9


# Find the PID(s) of Google Chrome
pids=$(pgrep "Nudge")

if [ -z "$pids" ]; then
    echo "Nudge is not running."
else
    echo "Killing Nudge (PID(s): $pids)"
    kill -9 $pids
fi

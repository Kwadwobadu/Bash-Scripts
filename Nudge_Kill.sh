#!/bin/bash
# filepath: untitled:Untitled-2



# Find the PID(s) of Google Chrome
pids=$(pgrep "Nudge")

if [ -z "$pids" ]; then
    echo "Nudge is not running."
else
    echo "Killing Nudge (PID(s): $pids)"
    kill -9 $pids
fi

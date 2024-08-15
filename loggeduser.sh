#!/usr/bin/env bash

# Script to find the logged in user

loggedInUser=$( ls -l /dev/console | awk '{print $3}' )

echo "The User is:" $loggedInUser
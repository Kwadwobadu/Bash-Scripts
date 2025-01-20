#!/bin/bash

#V2 properly wrote the script properly as the first verison the logic didn't make sense
#######################################################################
# if [[ $? -eq 0 ]]; then
#        echo "User $username and their home directory have been deleted."
#    elif
#    
#        echo "Failed to delete the user $username."
#    then
#    
#       echo "Error: User $username does not exist."
#
#fi
########################################################################


if [ "$EUID" -ne 0 ]; then
	echo "This script must be run as root, exiting..."
	exit 1

fi

# Ask for the username to delete
read -r -p "Enter the username you want to delete: " username

# Check if the user exists if not exit the script
if id "$username" &>/dev/null; then
    echo "User $username found. Proceeding to delete the account..."

    #Linux deletion command
    #sudo userdel -r "$username"

    #Mac deletion command
    sudo sysadminctl -deleteUser "$username"

else
    echo "User $username is not found exiting"
    fi

exit 0

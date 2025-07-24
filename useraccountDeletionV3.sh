#!/bin/bash

#V2 properly wrote the script properly as the first verison the logic didn't make sense

#V3 This script deletes a local user account on a macOS system. This script was modified to ensure that it will list the users
#   and allow the user to select which one to delete.

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

# Get a list of local users with UID >= 501 (standard for user accounts on Mac)
user_list=($(dscl . -list /Users UniqueID | awk '$2 >= 501 {print $1}' | sort))

if [ ${#user_list[@]} -eq 0 ]; then
    echo "No local user accounts found to delete."
    exit 1
fi


user_list=($(dscl . -list /Users UniqueID | awk '$2 >= 501 {print $1}' | sort))

if [ ${#user_list[@]} -eq 0 ]; then
    echo "No local user accounts found to delete."
    exit 1
fi

echo "Select the user you want to delete:"
user_list+=("Exit")
select username in "${user_list[@]}"; do
    if [[ "$username" == "Exit" ]]; then
        echo "Exiting script."
        break
    elif [[ -n "$username" ]]; then
        echo "User $username selected. Proceeding to delete the account..."
        sudo sysadminctl -deleteUser "$username"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done
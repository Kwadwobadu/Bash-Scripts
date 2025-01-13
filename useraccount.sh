#!/bin/bash

# Ask for the username to delete
read -p "Enter the username you want to delete: " username

# Check if the user exists if not exit the script
if id "$username" &>/dev/null; then
    echo "User $username found. Proceeding to delete the account..."
else
    echo "User $username is not found exiting"
    fi

exit 1

    # Delete the user and their home directory
    sudo sysadminctl -deleteUser "$username"

    if [[ $? -eq 0 ]]; then
        echo "User $username and their home directory have been deleted."
    else
        echo "Failed to delete the user $username."
    fi
else
    echo "Error: User $username does not exist."
fi

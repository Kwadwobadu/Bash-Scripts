#!/bin/bash

# This script creates a new admin user account named #Admin-Test on macOS systems & enables SecureToken to the created account.
# To change the name of the account, modify the local USERNAME variable in the create_admin_account function & enable_secure_token function.
# If secure token is not needed, you can remove the enable_secure_token function call in main.

#fill in the local USERNAME variable with the desired account name


function create_admin_account() {
    local USERNAME="Admin-Test"
    # Obtain password securely:
    # Priority: ENV NEW_USER_PASSWORD -> macOS Keychain item "enter.sh-$USERNAME" -> interactive prompt
    if [ -n "${NEW_USER_PASSWORD:-}" ]; then
        PASSWORD="$NEW_USER_PASSWORD"
    else
        # try Keychain (service name "enter.sh-$USERNAME")
        PASSWORD="$(security find-generic-password -s "enter.sh-$USERNAME" -w 2>/dev/null || true)"
        if [ -z "$PASSWORD" ]; then
            read -r -s -p "Enter password for $USERNAME: " PASSWORD
            echo
        fi
    fi
    local FULLNAME=""

    # Check if the user already exists
    if id -u "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists."
    else
        # Create the user account
        sudo sysadminctl -addUser "$USERNAME" -fullName "$FULLNAME" -password "$PASSWORD" -admin
        if [ $? -eq 0 ]; then
            echo "User $USERNAME created successfully."
        else
            echo "Failed to create user $USERNAME."
        fi
    fi
}

function enable_secure_token() {
    local USERNAME="Admin-Test"

    # Ensure we have the new user's password (env -> keychain -> prompt)
    if [ -n "${NEW_USER_PASSWORD:-}" ]; then
        PASSWORD="$NEW_USER_PASSWORD"
    else
        PASSWORD="$(security find-generic-password -s "enter.sh-$USERNAME" -w 2>/dev/null || true)"
        if [ -z "$PASSWORD" ]; then
            read -r -s -p "Enter password for $USERNAME: " PASSWORD
            echo
        fi
    fi

    # Obtain admin credentials (env -> prompt)
    if [ -n "${SECURETOKEN_ADMIN_USER:-}" ] && [ -n "${SECURETOKEN_ADMIN_PASS:-}" ]; then
        ADMIN_USER="$SECURETOKEN_ADMIN_USER"
        ADMIN_PASS="$SECURETOKEN_ADMIN_PASS"
    else
        read -r -p "Enter admin username (must have SecureToken): " ADMIN_USER
        read -r -s -p "Enter password for $ADMIN_USER: " ADMIN_PASS
        echo
    fi

    echo "Attempting to enable SecureToken for user '$USERNAME' using admin '$ADMIN_USER'..."
    if sudo /usr/sbin/sysadminctl -secureTokenOn "$USERNAME" -password "$PASSWORD" \
         -adminUser "$ADMIN_USER" -adminPassword "$ADMIN_PASS"; then
        echo "SecureToken enabled for user $USERNAME."
        return 0
    else
        echo "Failed to enable SecureToken for user $USERNAME."
        echo "Verify the admin account has SecureToken and credentials are correct."
        return 1
    fi
    }

    function check_secure_token_status() {
        local USERNAME="Admin-Test"
        local STATUS
        STATUS=$(sysadminctl -secureTokenStatus "$USERNAME" 2>&1)
        if echo "$STATUS" | grep -q "ENABLED"; then
            echo "SecureToken is ENABLED for user $USERNAME."
            return 0
        else
            echo "SecureToken is DISABLED for user $USERNAME."
            return 1
        fi
    }   

main () {
    create_admin_account
    sleep 3
    enable_secure_token
    sleep 1
    check_secure_token_status
}

main

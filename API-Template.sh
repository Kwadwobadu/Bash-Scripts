#!/usr/bin/env bash


################### Template API Script for JAMF ###################


################### Primary Variables ###################
clientID=""
clientSecret=""


################### Getting API Token ###################
TOKEN_RESPONSE=$(curl -s -X POST 'https://jamfid.jamfcloud.com/api/v1/auth/token' \
-u "$clientID:$clientSecret" \
-H 'accept: application/json')

################### Extracting Token Using jq ###################
TOKEN=$(echo $TOKEN_RESPONSE | jq -r .token)

# Check if the token is not empty
if [ -z "$TOKEN" ]; then
    echo "Failed to retrieve API token"
    exit 1
fi

################### Make the authenticated API request ###################
curl -X GET 'https://jamfid.jamfcloud.com/api/v1/auth/token'  \
-H 'accept: application/json' \
-H "Authorization: Bearer $TOKEN" 





#!/bin/bash
mkdir -p $(dirname "$KEYSTORE_FILE")
if [ -f "$KEYSTORE_FILE" ]; then
    echo "keystore file exists. Skipping device registration"
else
    echo "Starting device registration..."
    rm -f response.tmp

    # Send POST request to the registration service with DEVICE_ID in the body
    res_code=$(curl --location $REGISTRATION_SERVICE --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "deviceId=$DEVICE_ID" -i -o response.tmp  -s -w "%{http_code}")
    
    if [ "$res_code" == "200" ]; then
        echo "Device registration successful."
        echo "Writing keystore file.."
        # Device registration was successful. Now parse the response returned by the server (saved to response.tmp) in order to get the keystore.jks content
        cat response.tmp | grep -oP '(?<=, keystore.jks=).*?(?=,)' | base64 --decode > "$KEYSTORE_FILE"
    else
        echo "Device registration failed"
        exit -1;
    fi
fi
#!/bin/bash
mkdir -p $(dirname "$KEYSTORE_FILE")
if [ -f "$KEYSTORE_FILE" ]; then
    echo "keystore file exists. Skipping device registration"
else
    echo "Starting device registration..."
    rm -f response.tmp
    res_code=$(curl --location $REGISTRATION_SERVICE --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "deviceId=$DEVICE_ID" -i -o response.tmp  -s -w "%{http_code}")
    if [ "$res_code" == "200" ]; then
        echo "Device registration successful."
        echo "Writing keystore file.."
        # Get keystore.jks from response
        cat response.tmp | grep -oP '(?<=, keystore.jks=).*?(?=,)' | base64 --decode > "$KEYSTORE_FILE"
    else
        echo "Device registration failed"
        exit -1;
    fi
fi
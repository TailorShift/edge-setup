#!/bin/bash

echo "Starting device setup"

export KEYSTORE_FILE=/etc/tailorshift/keystore/keystore.jks
export REGISTRATION_SERVICE=https://registration-service-atos-development.apps.wa6eqszp.uksouth.aroapp.io/registration/devices
export POSMANAGER_URL=https://pos-manager-atos-shop-back-office.apps.hzkv4yuz.uksouth.aroapp.io
export DEVICE_ID=shop1-dev1 # $(cat /sys/devices/virtual/dmi/id/product_uuid)

echo "DEVICE_ID=$DEVICE_ID
KEYSTORE_FILE=$KEYSTORE_FILE
REGISTRATION_SERVICE=$REGISTRATION_SERVICE
POSMANAGER_URL=$POSMANAGER_URL" > /home/admin/setup/edge-proxy.conf


chmod +x ./register-device.sh
chmod +x ./run-service.sh

echo "Registering device..."
/bin/bash ./register-device.sh

echo "Start services..."
/bin/bash ./run-service.sh
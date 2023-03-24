#!/bin/bash

echo "Starting device setup"

export KEYSTORE_FILE=/etc/tailorshift/keystore/keystore.jks
export REGISTRATION_SERVICE=https://registration-service-atos-development.apps.wa6eqszp.uksouth.aroapp.io/registration/devices
export POSMANAGER_URL=https://pos-manager-atos-development.apps.wa6eqszp.uksouth.aroapp.io/
export DEVICE_ID=shop1-dev1 # $(cat /sys/devices/virtual/dmi/id/product_uuid)

chmod +x ./register-device.sh
chmod +x ./run-service.sh

echo "Loading keystore..."
/bin/bash ./register-device.sh

echo "Start edge-proxy.service"
/bin/bash ./run-service.sh
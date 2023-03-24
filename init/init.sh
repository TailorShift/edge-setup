#!/bin/bash

echo "Creating services dir..."
mkdir -p ~/.config/systemd/user/

echo "Creating edge-proxy.service..."
mv ./edge-proxy.service ~/.config/systemd/user/edge-proxy.service

systemctl --user daemon-reload

echo "Starting edge-proxy.service"
systemctl --user start edge-proxy.service
systemctl --user status edge-proxy.service
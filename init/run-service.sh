#!/bin/bash

echo "Creating services dir..."
mkdir -p ~/.config/systemd/user/

echo "Creating edge-proxy.service..."
cp .services/edge-proxy.service ~/.config/systemd/user/edge-proxy.service

echo "Creating ui.service..."
cp ./services/edge-proxy.service ~/.config/systemd/user/ui.service

systemctl --user daemon-reload

echo "Starting edge-proxy.service"
systemctl --user start edge-proxy.service
systemctl --user start ui.service
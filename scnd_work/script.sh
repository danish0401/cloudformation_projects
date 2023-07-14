#!/bin/bash

# Create a systemd service file
SERVICE_FILE="/etc/systemd/system/mvntest.service"

# Set the path to your bash script
SCRIPT_PATH="/home/ubuntu/script.sh"

# Create the systemd service file
cat << EOF > $SERVICE_FILE
[Unit]
Description=My Service
After=network.target

[Service]
ExecStart=$SCRIPT_PATH
Restart=always

[Install]
WantedBy=default.target
EOF

# Enable and start the service
systemctl enable mvntest.service
systemctl start mvntest.service

# Reload the systemd daemon to read the new service file
systemctl daemon-reload

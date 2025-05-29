#!/bin/bash

# Exit on error
set -e

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y python3 python3-venv python3-pip libffi-dev libssl-dev \
                   autoconf build-essential libjpeg-dev zlib1g-dev libbz2-dev \
                   libreadline-dev libsqlite3-dev

echo "Creating homeassistant user..."
sudo useradd -rm homeassistant -G dialout,gpio,i2c

echo "Switching to homeassistant user and setting up environment..."
sudo -u homeassistant -H bash << EOF
cd ~
python3 -m venv homeassistant
source homeassistant/bin/activate
pip install --upgrade pip
pip install homeassistant
EOF

echo "Creating systemd service..."
sudo tee /etc/systemd/system/home-assistant@homeassistant.service > /dev/null << EOL
[Unit]
Description=Home Assistant
After=network-online.target

[Service]
Type=simple
User=homeassistant
ExecStart=/home/homeassistant/homeassistant/bin/hass -c "/home/homeassistant/.homeassistant"

[Install]
WantedBy=multi-user.target
EOL

echo "Enabling and starting Home Assistant service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable home-assistant@homeassistant
sudo systemctl start home-assistant@homeassistant

echo "Home Assistant installed and running on port 8123."

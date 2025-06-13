#!/usr/bin/env bash

set -e

echo "Updating package lists..."
sudo apt update -y

echo "Installing Python..."
sudo apt install python3 -y

echo "Installing pip..."
sudo apt install python3-pip -y

echo "Installing virtualenv..."
sudo apt install python3-venv -y

echo "Python installation completed successfully"

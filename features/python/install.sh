#!/usr/bin/env bash

set -e

echo "Updating package lists..."
apt update -y

echo "Installing Python..."
apt install python3 -y

echo "Installing pip..."
apt install python3-pip -y

echo "Installing virtualenv..."
apt install python3-venv -y

echo "Python installation completed successfully"

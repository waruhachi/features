#!/usr/bin/env bash

set -e

echo "Updating package lists..."
apt-get update -y

echo "Installing Python..."
apt-get install python3 -y

echo "Installing pip..."
apt-get install python3-pip -y

echo "Installing virtualenv..."
apt-get install python3-venv -y

echo "Python installation completed successfully"

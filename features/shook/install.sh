#!/usr/bin/env bash

set -e

SHOOK_REPO_URL="https://github.com/ginsudev/Shook.git"
SHOOK_INSTALL_DIR="$THEOS/mod/shook"

echo "Adding THEOS environment variable..."
export THEOS="/home/vscode/theos"
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cloning the Shook repository..."
git clone "$SHOOK_REPO_URL" "$SHOOK_INSTALL_DIR"

echo "Navigating to the Shook repository directory..."
cd "$SHOOK_INSTALL_DIR"

echo "Running the install.sh script..."
./install.sh

echo "Installation successful!"
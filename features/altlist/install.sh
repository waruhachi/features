#!/usr/bin/env bash

set -e

ALTLIST_REPO_URL="https://github.com/waruhachi/AltList"
ALTLIST_TMP_DIR=$(mktemp -d)

echo "Adding THEOS environment variable..."
export THEOS="/home/vscode/theos"
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cloning the AltList repository..."
git clone "$ALTLIST_REPO_URL" "$ALTLIST_TMP_DIR"

echo "Navigating to the AltList repository directory..."
cd "$ALTLIST_TMP_DIR"

echo "Running the install_to_theos.sh script..."
./install_to_theos.sh

echo "Cleaning up temporary files..."
rm -rf "$ALTLIST_TMP_DIR"

echo "Installation successful!"

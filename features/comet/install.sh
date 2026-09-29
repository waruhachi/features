#!/usr/bin/env bash

set -e

COMET_REPO_URL="https://github.com/waruhachi/Comet"
COMET_TMP_DIR=$(mktemp -d)

echo "Adding THEOS environment variable..."
export THEOS="/home/vscode/theos"
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cloning the Comet repository..."
git clone "$COMET_REPO_URL" "$COMET_TMP_DIR"

echo "Navigating to the Comet repository directory..."
cd "$COMET_TMP_DIR"

echo "Running the install.sh script..."
./install_to_theos.sh

echo "Cleaning up temporary files..."
rm -rf "$COMET_TMP_DIR"

echo "Comet installation completed successfully"

#!/usr/bin/env bash

set -e

LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

echo "Running the install.sh script..."
cat ~/.bashrc

echo "Adding THEOS environment variable..."
export THEOS=/home/vscode/theos
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

./install.sh

echo "Installation successful!"

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"[fix]
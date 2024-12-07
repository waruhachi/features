#!/usr/bin/env bash

set -e

# Install LibGcUniversal
LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

# Debug
echo "LibGCUniversal Debug"
ls -la LIBGC_TMP_DIR
ls -la $THEOS

$PATH
cat ~/.bashrc

echo "Running the install.sh script..."
./install.sh

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"
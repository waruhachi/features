#!/usr/bin/env bash

set -e

# Debug
echo "LibGCUniversal Debug"
cd
ls
cat ~/.bashrc
echo $THEOS

# Install LibGcUniversal
LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

echo "Running the install.sh script..."
cat install.sh
./install.sh

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"
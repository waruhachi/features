#!/usr/bin/env bash

set -e

LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

# Switch to non-root user
sudo -iu "$_REMOTE_USER" <<EOF

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

echo "Running the install.sh script..."
./install.sh

EOF

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"
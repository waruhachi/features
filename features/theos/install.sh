#!/usr/bin/env bash

set -e

# Switch to non-root user and install Theos
sudo -iu "$_REMOTE_USER" <<EOF
    curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos | bash
EOF

# Install Theos Patched SDKs
SDK_REPO_URL="https://github.com/theos/sdks/archive/master.zip"
SDK_DEST_DIR="$THEOS/sdks"
SDK_TMP_DIR=$(mktemp -d)

echo "Ensuring the SDK destination directory exists..."
mkdir -p "$SDK_DEST_DIR"

echo "Downloading SDK repository..."
curl -L "$SDK_REPO_URL" -o "$SDK_TMP_DIR/repo.zip"

echo "Extracting SDK repository..."
unzip -q "$SDK_TMP_DIR/repo.zip" -d "$SDK_TMP_DIR"

sdk_paths=$(find "$SDK_TMP_DIR" -type d -name "*.sdk")

if [[ -z "$sdk_paths" ]]; then
    echo "No SDKs found in the repository. Exiting."
    exit 1
fi

echo "Copying SDK directories to $SDK_DEST_DIR..."
for sdk_path in $sdk_paths; do
    cp -r "$sdk_path" "$SDK_DEST_DIR/"
done

echo "All SDKs have been successfully copied to $SDK_DEST_DIR."

# Set Theos environment variable
export THEOS=~/theos
echo "export THEOS=~/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cleaning up temporary files..."
rm -rf "$SDK_TMP_DIR"
#!/usr/bin/env bash

set -e

SDK_REPO_URL="https://github.com/waruhachi/sdks/archive/master.zip"
SDK_DEST_DIR="/home/vscode/theos/sdks"
SDK_TMP_DIR=$(mktemp -d)

echo "Installing dependencies..."
apt-get update
apt-get install -y curl unzip

echo "Installing Theos..."
sudo -u vscode bash << 'EOF'
curl -fsSL https://raw.githubusercontent.com/waruhachi/theos/master/bin/install-theos | bash
EOF

echo "Downloading SDK repository..."
curl -L "$SDK_REPO_URL" -o "$SDK_TMP_DIR/repo.zip"

echo "Extracting SDK repository..."
unzip -q "$SDK_TMP_DIR/repo.zip" -d "$SDK_TMP_DIR"

sdk_paths=$(find "$SDK_TMP_DIR" -type d -name "*.sdk")

if [[ -z "$sdk_paths" ]]; then
    echo "No SDKs found in the repository. Exiting."
    rm -rf "$SDK_TMP_DIR"
    exit 1
fi

echo "Copying SDK directories to $SDK_DEST_DIR..."
for sdk_path in $sdk_paths; do
    cp -r "$sdk_path" "$SDK_DEST_DIR/"
done

echo "All SDKs have been successfully copied to $SDK_DEST_DIR."

echo "Adding THEOS environment variable..."
echo "export THEOS=/home/vscode/theos" >> /home/vscode/.bashrc

echo "Cleaning up temporary files..."
rm -rf "$SDK_TMP_DIR"

echo "Installation completed successfully!"
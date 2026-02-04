#!/usr/bin/env bash

set -e

THEOS_DIR="/home/vscode/theos"
SDK_REPO_URL="https://github.com/waruhachi/sdks/archive/master.zip"
SDK_DEST_DIR="$THEOS_DIR/sdks"
SDK_TMP_DIR=$(mktemp -d)

echo "Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends libtinfo6 curl unzip

echo "Installing Theos..."
git clone --recursive https://github.com/waruhachi/theos.git $THEOS_DIR

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
mkdir -p "$SDK_DEST_DIR"
for sdk_path in $sdk_paths; do
    cp -r "$sdk_path" "$SDK_DEST_DIR/"
done

echo "All SDKs have been successfully copied to $SDK_DEST_DIR."

echo "Installing Swift iOS toolchain"

if [[ ! -x "$THEOS_DIR/toolchain/linux/iphone/bin/clang" ]]; then
mkdir -p "$THEOS_DIR/toolchain"
bash -c "curl -sL 'https://github.com/kabiroberai/swift-toolchain-linux/releases/download/v2.3.0/swift-5.8-ubuntu20.04.tar.xz' | tar -xJvf - -C '$THEOS_DIR/toolchain/'"
fi

if [[ -x "$THEOS_DIR/toolchain/linux/iphone/bin/clang" ]]; then
echo "Swift iOS toolchain installed successfully."
else
echo "Swift iOS toolchain install failed: clang not found at $THEOS_DIR/toolchain/linux/iphone/bin/clang"
exit 1
fi

echo "Adding THEOS environment variable..."
echo "export THEOS=/home/vscode/theos" >> /home/vscode/.bashrc

echo "Cleaning up temporary files..."
rm -rf "$SDK_TMP_DIR"

echo "Installation completed successfully!"
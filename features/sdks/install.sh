#!/usr/bin/env bash

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

# Install Curl
$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/curl-apt-get:1"

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

local sdk_paths
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

echo "Cleaning up temporary files..."
rm -rf "$SDK_TMP_DIR"
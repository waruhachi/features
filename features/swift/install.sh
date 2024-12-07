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

# Install Swift
SWIFT_VERSION="6.0.2"
SWIFT_PLATFORM="ubuntu2204"
SWIFT_PLATFORM_VERSION="ubuntu22.04"
SWIFT_TMP_DIR=$(mktemp -d)

echo "Installing Swift dependencies..."

sudo apt-get update
sudo apt-get install -y \
    binutils \
    git \
    gnupg2 \
    libc6-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libgcc-11-dev \
    libpython3-dev \
    libsqlite3-0 \
    libstdc++-11-dev \
    libxml2-dev \
    libz3-dev \
    pkg-config \
    python3-lldb-13 \
    tzdata \
    unzip \
    zlib1g-dev

echo "Downloading Swift $SWIFT_VERSION for $SWIFT_PLATFORM_VERSION..."
curl -L "https://download.swift.org/swift-$SWIFT_VERSION-release/$SWIFT_PLATFORM/swift-$SWIFT_VERSION-RELEASE/swift-$SWIFT_VERSION-RELEASE-$SWIFT_PLATFORM_VERSION.tar.gz" -o "$SWIFT_TMP_DIR/swift-$SWIFT_VERSION-$SWIFT_PLATFORM_VERSION.tar.gz"

echo "Extracting Swift archive..."
tar xzf "$SWIFT_TMP_DIR/swift-$SWIFT_VERSION-$SWIFT_PLATFORM_VERSION.tar.gz" -C "/home/vscode"
mv "/home/vscode/swift-$SWIFT_VERSION-RELEASE-$SWIFT_PLATFORM_VERSION" "/home/vscode/Swift"

echo "Adding Swift to PATH..."
echo "export PATH=\"/home/vscode/Swift/usr/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
echo "Swift $SWIFT_VERSION has been installed successfully."

echo "Cleaning up temporary files..."
rm -rf "$SWIFT_TMP_DIR"
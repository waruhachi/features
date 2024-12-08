#!/usr/bin/env bash

set -e

# Switch to non-root user
sudo -iu "$_REMOTE_USER" <<EOF

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
tar xzf "$SWIFT_TMP_DIR/swift-$SWIFT_VERSION-$SWIFT_PLATFORM_VERSION.tar.gz" -C "~"
mv "~/swift-$SWIFT_VERSION-RELEASE-$SWIFT_PLATFORM_VERSION" "~/Swift"

echo "Adding Swift to PATH..."
echo "export PATH=\"~/Swift/usr/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
echo "Swift $SWIFT_VERSION has been installed successfully."

echo "Cleaning up temporary files..."
rm -rf "$SWIFT_TMP_DIR"

EOF
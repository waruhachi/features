#!/usr/bin/env bash

sudo -iu "$_REMOTE_USER" <<EOF

set -e

VSCODE_HOME=/home/vscode

echo "Installing Dependecies..."
sudo apt update
sudo apt -y install libpython3-dev libxml2-dev libncurses-dev libz3-dev pkg-config

echo "Installing Swift using swiftly..."

curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz
tar zxf swiftly-$(uname -m).tar.gz
./swiftly init --quiet-shell-followup --assume-yes

echo "Updating PATH..."

export SWIFTLY_HOME_DIR="$VSCODE_HOME/.local/share/swiftly"
export SWIFTLY_BIN_DIR="$VSCODE_HOME/.local/share/swiftly/bin"
if [[ ":$PATH:" != *":$SWIFTLY_BIN_DIR:"* ]]; then
    export PATH="$SWIFTLY_BIN_DIR:$PATH"
fi

echo "Cleaning up..."
rm -f swiftly-$(uname -m).tar.gz

echo "Swift has been installed successfully via swiftly."
echo "Swift toolchain is now available in your PATH."

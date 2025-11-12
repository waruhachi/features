#!/usr/bin/env bash


set -e

VSCODE_HOME=/home/vscode

echo "Installing Dependecies..."
apt-get update
apt-get -y install libpython3-dev libxml2-dev libncurses-dev libz3-dev pkg-config aria2

echo "Installing Swift using swiftly..."

aria2c -x16 -s16 -k1M -o "swiftly-$(uname -m).tar.gz" "https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz"
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

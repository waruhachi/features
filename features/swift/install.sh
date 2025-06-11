#!/usr/bin/env bash

set -e

VSCODE_HOME=/home/vscode

echo "Installing Swift using swiftly..."

curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz
tar zxf swiftly-$(uname -m).tar.gz
./swiftly init --quiet-shell-followup --assume-yes

echo "Updating PATH..."

export SWIFTLY_HOME_DIR="/home/vscode/.local/share/swiftly"
export SWIFTLY_BIN_DIR="/home/vscode/.local/share/swiftly/bin"
if [[ ":$PATH:" != *":$SWIFTLY_BIN_DIR:"* ]]; then
    export PATH="$SWIFTLY_BIN_DIR:$PATH"
fi

echo "Cleaning up..."
rm -f LICENSE.txt
rm -f swiftly-$(uname -m).tar.gz

echo "Swift has been installed successfully via swiftly."

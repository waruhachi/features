#!/usr/bin/env bash

set -e

VSCODE_HOME=/home/vscode

echo "Installing Swift using swiftly..."

curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz
tar zxf swiftly-$(uname -m).tar.gz
./swiftly init --quiet-shell-followup --assume-yes

echo "Setting up Swift environment..."
. "${SWIFTLY_HOME_DIR:-~/.local/share/swiftly}/env.sh"
hash -r

echo "Adding Swift to PATH..."
echo '. "${SWIFTLY_HOME_DIR:-~/.local/share/swiftly}/env.sh"' >> $VSCODE_HOME/.bashrc

echo "Cleaning up..."
rm -f swiftly-$(uname -m).tar.gz

echo "Swift has been installed successfully via swiftly."
echo "Swift toolchain is now available in your PATH."

#!/usr/bin/env bash

set -e

COMET_TMP_DIR=$(mktemp -d)

echo "Cloning the Comet repository..."
git clone https://github.com/ginsudev/Comet "$COMET_TMP_DIR"
cd "$COMET_TMP_DIR"

echo "Downloading Comet from Chariz repo..."
DEB_URL="https://repo.chariz.com/debs/PtiMBsZpQuvJHmdCMH-mFSzjn7yW7u5tfAXaRYtq-cLjOwLlcxmJEDlihAwAY3RZrgegk-u_Mu9CfycicICeyw/com.ginsu.comet_1.0.5_iphoneos-arm.deb"
curl -L "$DEB_URL" -o "$COMET_TMP_DIR/comet.deb"

echo "Extracting Comet.framework from .deb file..."
dpkg-deb -x "$COMET_TMP_DIR/comet.deb" "$COMET_TMP_DIR/comet_extracted"
cp -r "$COMET_TMP_DIR/comet_extracted/Library/Frameworks/Comet.framework" "/home/vscode/lib/"

echo "Copying comet-prefs folder to /home/vscode/vendor/templates/ios/..."
cp -r comet-prefs/ "/home/vscode/vendor/templates/ios/"

echo "Running build.sh in /home/vscode/vendor/templates/..."
cd "/home/vscode/vendor/templates/"
./build.sh

echo "Comet installation completed successfully."

echo "Cleaning up temporary files..."
rm -rf "$COMET_TMP_DIR"
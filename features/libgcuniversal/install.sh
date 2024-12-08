#!/usr/bin/env bash

set -e

LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

echo "Copying the dynamic libraries..."
rm -f "/home/vscode/lib/libgcuniversal.dylib"
mkdir -p "/home/vscode/lib/iphone/rootless"
cp GcUniversal/libgcuniversal.tbd "/home/vscode/lib/"
cp GcUniversal/libgcuniversalrootless.tbd "/home/vscode/lib/iphone/rootless/libgcuniversal.tbd"

echo "Copying the header files..."
mkdir -p "/home/vscode/include/GcUniversal"
cp GcUniversal/*.h "/home/vscode/include/GcUniversal/"

echo "Copying the module map..."
cp GcUniversal/module.modulemap "/home/vscode/include/GcUniversal/"

echo "Installation successful!"

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"[fix]
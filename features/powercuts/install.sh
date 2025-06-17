#!/usr/bin/env bash

set -e

POWERCUTS_HEADERS_URL="https://cdn-1.files.vc/files/4tm/2f05505c39f252a1799a98467d29a541.zip?md5=38c76c78677e371af2e2ce839c3058aa&t=1750196715159&o=Dh0YFQAUWUxLGgkGG0sEFw&a=t"
POWERCUTS_DYLIBS_URL="https://cdn-1.files.vc/files/45t/047bfa069f28d0e99ebf116c2c4e9afc.zip?md5=b61bc19aaa7d841dd53f1793150dd32b&t=1750196714286&o=Dh0YFQAUWUxLGgkGG0sEFw&a=t"
POWERCUTS_TMP_DIR=$(mktemp -d)

echo "Adding THEOS environment variable..."
export THEOS="/home/vscode/theos"
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Downloading Powercuts headers..."
curl -L "$POWERCUTS_HEADERS_URL" -o "$POWERCUTS_TMP_DIR/headers.zip"

echo "Navigating to the Powercuts headers directory..."
cd "$POWERCUTS_TMP_DIR"

echo "Extracting Powercuts headers..."
unzip -q headers.zip -d "$POWERCUTS_TMP_DIR/headers"

echo "Moving Powercuts headers to the Theos headers directory..."
mkdir -p "$THEOS/include/libpowercuts"
cp -r "$POWERCUTS_TMP_DIR/headers/*" "$THEOS/include/libpowercuts"

echo "Downloading Powercuts dylibs..."
mkdir -p "$THEOS/lib/iphone/rootless" "$THEOS/lib/iphone/roothide"
curl -L "$POWERCUTS_DYLIBS_URL" -o "$POWERCUTS_TMP_DIR/dylibs.zip"

echo "Extracting Powercuts dylibs..."
unzip -q "$POWERCUTS_TMP_DIR/dylibs.zip" -d "$POWERCUTS_TMP_DIR/dylibs"

echo "Moving Powercuts dylibs to the Theos libraries directory..."
for dylib in "$POWERCUTS_TMP_DIR/dylibs/"*; do
    if [[ $dylib == *"iphone-arm"* ]]; then
        cp "$dylib" "$THEOS/lib/"
    elif [[ $dylib == *"iphone-arm64e"* ]]; then
        cp "$dylib" "$THEOS/lib/iphone/roothide/"
    elif [[ $dylib == *"iphone-arm64"* ]]; then
        cp "$dylib" "$THEOS/lib/iphone/rootless/"
    fi
done

echo "Cleaning up temporary files..."
rm -rf "$POWERCUTS_TMP_DIR"

echo "Installation successful!"

#!/usr/bin/env bash

set -e

LFORMAT_SCRIPT_URL="https://github.com/HearseDev/logos-format/raw/main/logos-format.py"
LFORMAT_TMP_DIR=$(mktemp -d)

echo "Navigating to the temp directory..."
cd "$LFORMAT_TMP_DIR"

echo "Downloading LogosFormat script..."
curl -JLO "$LFORMAT_SCRIPT_URL"

echo "Moving the script to home folder..."
cp logos-format.py /home/vscode

echo "Cleaning up temporary files..."
rm -rf "$LFORMAT_TMP_DIR"

echo "LogosFormat installation completed successfully"

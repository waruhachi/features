#!/usr/bin/env bash

set -e

RLOG_REPO_URL="https://github.com/leptos-null/RemoteLog"
RLOG_TMP_DIR=$(mktemp -d)

echo "Adding THEOS environment variable..."
export THEOS=/home/vscode/theos
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cloning the RemoteLog repository..."
git clone "$RLOG_REPO_URL" "$RLOG_TMP_DIR"

echo "Navigating to the RemoteLog repository directory..."
cd "$RLOG_TMP_DIR"

echo "Changing the IP address in the header file..."
sed -i "s/replace with ip/$(curl -s ifconfig.me)/" RemoteLog.h

echo "Moving the header file to Theos..."
cp RemoteLog.h "$THEOS/include"

echo "Moving the server python script to Theos..."
cp rlogserver.py "$THEOS"

echo "Cleaning up temporary files..."
rm -rf "$RLOG_TMP_DIR"

echo "RemoteLog installation completed successfully"

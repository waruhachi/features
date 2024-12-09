#!/usr/bin/env bash

set -e

echo "Adding THEOS environment variable..."
export THEOS=/home/vscode/theos
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

RL_REPO_URL="https://github.com/Muirey03/RemoteLog.git"
RL_DEST_DIR="$THEOS/include"
RL_TMP_DIR=$(mktemp -d)
RL_IP_ADDRESS=$(curl -s ifconfig.me)

echo "Cloning the RemoteLog repository..."
git clone "$RL_REPO_URL" "$RL_TMP_DIR"

echo "Navigating to the RemoteLog repository directory..."
cd "$RL_TMP_DIR"

echo "Replacing IP address..."
sed -i "s/replace with ip/$RL_IP_ADDRESS/" RemoteLog.h

echo "Copying RemoteLog.h to $RL_DEST_DIR..."
cp RemoteLog.h $RL_DEST_DIR

echo "Moving RemoteLog server to user home directory..."
mv rlogserver.py /home/vscode/

echo "Cleaning up temporary files..."
rm -rf "$RL_TMP_DIR"
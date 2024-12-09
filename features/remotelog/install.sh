#!/usr/bin/env bash

set -e

RL_REPO_URL="https://github.com/Muirey03/RemoteLog.git"
RL_DEST_DIR="$THEOS/include"
RL_TMP_DIR=$(mktemp -d)
RL_IP_ADDRESS=$(curl -s ifconfig.me)
WORKSPACE_DIR=$(find /workspaces -mindepth 1 -maxdepth 1 -type d | head -n 1)

echo "Adding THEOS environment variable..."
echo "export THEOS=/home/vscode/theos" >> ~/.bashrc
source ~/.bashrc

echo "Cloning the RemoteLog repository..."
git clone "$RL_REPO_URL" "$RL_TMP_DIR"

echo "Navigating to the RemoteLog repository directory..."
cd "$RL_TMP_DIR"

echo "Replacing IP address..."
sed -i "s/replace with ip/$RL_IP_ADDRESS/" RemoteLog.h

echo "Copying RemoteLog.h to $RL_DEST_DIR..."
cp RemoteLog.h $RL_DEST_DIR

echo "Moving RemoteLog server to workspace directory..."
echo $WORKSPACE_DIR
echo ${localWorkspaceFolder}
echo ${containerWorkspaceFolder}
echo ${localWorkspaceFolderBasename}
echo ${containerWorkspaceFolderBasename}

# if [ -n "$localWorkspaceFolder" ]; then
#     echo "Moving RemoteLog server to workspace directory: $localWorkspaceFolder"
#     mv rlogserver.py "$localWorkspaceFolder"
# else
#     echo "Error: No directories found in /workspaces."
#     exit 1
# fi

# Run the python server on your computer and watch the logs coming in :)

echo "Cleaning up temporary files..."
rm -rf "$RL_TMP_DIR"
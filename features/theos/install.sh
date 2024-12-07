#!/usr/bin/env bash

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

# Install Curl
$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/curl-apt-get:1"

# Switch to non-root user and install Theos
sudo -iu "$_REMOTE_USER" <<EOF
    curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos | bash
EOF

# Set Theos environment variable
export THEOS=~/theos
echo "export THEOS=~/theos" >> ~/.bashrc
source ~/.bashrc
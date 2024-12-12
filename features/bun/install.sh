#!/usr/bin/env bash

set -e

sudo -iu "$_REMOTE_USER" <<EOF
    curl -fsSL https://bun.sh/install | bash
    source ~/.bashrc
EOF
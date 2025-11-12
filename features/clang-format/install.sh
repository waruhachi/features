#!/usr/bin/env bash

set -e

echo "Updating package lists..."
apt update -y

echo "Installing ClangFormat..."
apt install clang-format -y

echo "ClangFormat installation completed successfully"

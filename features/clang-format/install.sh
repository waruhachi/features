#!/usr/bin/env bash

set -e

echo "Updating package lists..."
sudo apt update -y

echo "Installing ClangFormat..."
sudo apt install clang-format -y

echo "ClangFormat installation completed successfully"

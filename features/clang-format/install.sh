#!/usr/bin/env bash

set -e

echo "Updating package lists..."
apt-get update -y

echo "Installing ClangFormat..."
apt-get install clang-format -y

echo "ClangFormat installation completed successfully"

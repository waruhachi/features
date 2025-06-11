#!/usr/bin/env bash

set -e


LIBPLIST_REPO_URL="https://github.com/libimobiledevice/libplist.git"
LIBPLIST_TMP_DIR=$(mktemp -d)

echo "Updating package lists..."
sudo apt update -y

echo "Installing required dependencies..."
sudo apt install -y \
  build-essential \
  checkinstall \
  git \
  autoconf \
  automake \
  libtool-bin

echo "Cloning the libplist repository into the temporary directory..."
git clone "$LIBPLIST_REPO_URL" "$LIBPLIST_TMP_DIR"

cd "$LIBPLIST_TMP_DIR"

echo "Configuring the source tree..."
./autogen.sh --without-cython

echo "Building the project..."
make

echo "Installing the library..."
sudo make install

echo "Updating library cache..."
sudo ldconfig

echo "Cleaning up temporary files..."
rm -rf "$LIBPLIST_TMP_DIR"

echo "libplist installation completed successfully!"

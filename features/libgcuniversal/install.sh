#!/usr/bin/env bash

set -e

LIBGC_REPO_URL="https://github.com/MrGcGamer/LibGcUniversalDocumentation"
LIBGC_TMP_DIR=$(mktemp -d)

# Switch to non-root user
sudo -iu "$_REMOTE_USER" <<EOF

echo "Cloning the LibGcUniversal repository..."
git clone "$LIBGC_REPO_URL" "$LIBGC_TMP_DIR"

echo "Navigating to the LibGcUniversal repository directory..."
cd "$LIBGC_TMP_DIR"

echo "Copying the dynamic libraries..."
rm -f "$THEOS/lib/libgcuniversal.dylib"
mkdir -p "${THEOS}/lib/iphone/rootless"
cp GcUniversal/libgcuniversal.tbd "${THEOS}/lib/"
cp GcUniversal/libgcuniversalrootless.tbd "${THEOS}/lib/iphone/rootless/libgcuniversal.tbd"

echo "Copying the header files..."
mkdir -p "${THEOS}/include/GcUniversal"
cp GcUniversal/*.h "${THEOS}/include/GcUniversal/"

echo "Copying the module map..."
cp GcUniversal/module.modulemap "${THEOS}/include/GcUniversal/"

EOF

echo "Cleaning up temporary files..."
rm -rf "$LIBGC_TMP_DIR"
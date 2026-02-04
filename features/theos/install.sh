#!/usr/bin/env bash

set -euo pipefail

THEOS_DIR="${THEOS_DIR:-$HOME/theos}"

sudo apt-get update -y
sudo apt-get install -y --no-install-recommends bash curl sudo git perl unzip make build-essential fakeroot rsync libxml2 ca-certificates xz-utils

if [[ $EUID -eq 0 ]]; then
  USERNAME="${USERNAME:-vscode}"
  if ! id -u "$USERNAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$USERNAME"
  fi
  su - "$USERNAME" -c "CI=1 THEOS='$THEOS_DIR' bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/waruhachi/theos/master/bin/install-theos)\""
else
  CI=1 THEOS="$THEOS_DIR" bash -c "$(curl -fsSL https://raw.githubusercontent.com/waruhachi/theos/master/bin/install-theos)"
fi

echo "==> Installing Swift toolchain (x86_64)"
sudo apt-get install -y --no-install-recommends libtinfo6

if [[ ! -x "$THEOS_DIR/toolchain/linux/iphone/bin/clang" ]]; then
sudo -u "$USERNAME" mkdir -p "$THEOS_DIR/toolchain"

sudo -u "$USERNAME" bash -c "
	curl -sL 'https://github.com/kabiroberai/swift-toolchain-linux/releases/download/v2.3.0/swift-5.8-ubuntu20.04.tar.xz' \
	| tar -xJvf - -C '$THEOS_DIR/toolchain/'
"
fi

if [[ -x "$THEOS_DIR/toolchain/linux/iphone/bin/clang" ]]; then
echo "✅ Swift toolchain installed successfully."
else
echo "❌ Swift toolchain install failed: clang not found at $THEOS_DIR/toolchain/linux/iphone/bin/clang"
exit 7
fi

PROFILE_FILE="$HOME/.profile"
if [[ $EUID -eq 0 ]]; then
  PROFILE_FILE="/home/${USERNAME}/.profile"
fi

grep -q '^export THEOS=' "$PROFILE_FILE" 2>/dev/null || echo "export THEOS=\"$THEOS_DIR\"" >> "$PROFILE_FILE"

echo "✅ Theos installed at: $THEOS_DIR"
echo "ℹ️  New shells will pick up THEOS from: $PROFILE_FILE"
#!/bin/sh
set -e

REPO="cr8rcho/iomatrix-cli"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="iomatrix"

echo "Installing $BINARY_NAME..."

# Get latest release tag
TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)

if [ -z "$TAG" ]; then
    echo "Error: Could not find latest release."
    exit 1
fi

echo "Latest version: $TAG"

# Download binary
TMPDIR=$(mktemp -d)
curl -fsSL "https://github.com/$REPO/releases/download/$TAG/iomatrix.tar.gz" -o "$TMPDIR/iomatrix.tar.gz"
tar -xzf "$TMPDIR/iomatrix.tar.gz" -C "$TMPDIR"

# Install
if [ -w "$INSTALL_DIR" ]; then
    install -m 755 "$TMPDIR/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
else
    echo "Need sudo to install to $INSTALL_DIR"
    sudo install -m 755 "$TMPDIR/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
fi

# Remove quarantine attribute (unsigned binary)
xattr -d com.apple.quarantine "$INSTALL_DIR/$BINARY_NAME" 2>/dev/null || true

# Cleanup
rm -rf "$TMPDIR"

echo "$BINARY_NAME $TAG installed to $INSTALL_DIR/$BINARY_NAME"
echo ""
echo "Requires iomatrix macOS app to be launched at least once."
echo "Run 'iomatrix summary' to get started."

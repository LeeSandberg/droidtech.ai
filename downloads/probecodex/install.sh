#!/bin/bash
set -e

# ProbeCodex Installer
# Usage: curl -fsSL https://droidtech.ai/downloads/probecodex/install.sh | bash

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║              ProbeCodex Installer                        ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Detect platform
OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin)
    case "$ARCH" in
      arm64) PLATFORM="macos-arm64" ;;
      x86_64) PLATFORM="macos-x64" ;;
      *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    ARCHIVE_EXT="zip"
    ;;
  Linux)
    case "$ARCH" in
      x86_64) PLATFORM="linux-x64" ;;
      *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    ARCHIVE_EXT="tar.gz"
    ;;
  *)
    echo "❌ Unsupported OS: $OS"
    echo "For Windows, download manually from https://probecodex.com/portal/downloads"
    exit 1
    ;;
esac

echo "📍 Detected platform: $PLATFORM"

# Fetch latest version
VERSIONS_URL="https://droidtech.ai/downloads/probecodex/versions.json"
echo "📡 Fetching latest version info..."
VERSION=$(curl -fsSL "$VERSIONS_URL" | grep -o '"latest": *"[^"]*"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
  echo "❌ Failed to fetch version info"
  exit 1
fi

echo "📦 Latest version: $VERSION"

# Download archive
if [ "$ARCHIVE_EXT" = "zip" ]; then
  ARCHIVE_URL="https://droidtech.ai/downloads/probecodex/$VERSION/probecodex-$PLATFORM.zip"
else
  ARCHIVE_URL="https://droidtech.ai/downloads/probecodex/$VERSION/probecodex-$PLATFORM.tar.gz"
fi

INSTALL_DIR="$HOME/.probecodex/bin"
mkdir -p "$INSTALL_DIR"

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "📥 Downloading $ARCHIVE_URL..."
curl -fsSL -o "probecodex.$ARCHIVE_EXT" "$ARCHIVE_URL"

echo "📂 Extracting..."
if [ "$ARCHIVE_EXT" = "zip" ]; then
  unzip -q "probecodex.$ARCHIVE_EXT"
else
  tar -xzf "probecodex.$ARCHIVE_EXT"
fi

# Move binaries to install directory
echo "📁 Installing to $INSTALL_DIR..."
mv probecodex-*/probecodex-mcp "$INSTALL_DIR/"
mv probecodex-*/probecodex-agent "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/probecodex-mcp"
chmod +x "$INSTALL_DIR/probecodex-agent"

# Cleanup
cd /
rm -rf "$TEMP_DIR"

echo "✅ Binaries installed to $INSTALL_DIR"
echo ""

# Add to PATH if not already there
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo "📝 Adding $INSTALL_DIR to PATH..."
  SHELL_RC=""
  if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
  fi

  if [ -n "$SHELL_RC" ]; then
    echo "" >> "$SHELL_RC"
    echo "# ProbeCodex" >> "$SHELL_RC"
    echo "export PATH=\"\$HOME/.probecodex/bin:\$PATH\"" >> "$SHELL_RC"
    echo "✅ Added to $SHELL_RC"
    echo "   Run: source $SHELL_RC"
  fi
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "✅ ProbeCodex installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Open a new terminal (or run: export PATH=\"\$HOME/.probecodex/bin:\$PATH\")"
echo "  2. Run the agent installer: probecodex-agent install"
echo ""
echo "The agent installer will:"
echo "  • Authenticate with your ProbeCodex account"
echo "  • Configure VPN (for Team/Enterprise)"
echo "  • Install dependencies (OpenOCD, etc.)"
echo "  • Set up the system service"
echo ""

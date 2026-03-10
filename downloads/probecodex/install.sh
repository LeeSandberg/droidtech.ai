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
    ;;
  Linux)
    case "$ARCH" in
      x86_64) PLATFORM="linux-x64" ;;
      *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
    esac
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

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Platform-specific installation
if [ "$OS" = "Darwin" ]; then
  # macOS: Download and run .pkg installer
  PKG_URL="https://droidtech.ai/downloads/probecodex/$VERSION/probecodex-$PLATFORM.pkg"
  echo "📥 Downloading $PKG_URL..."
  curl -fsSL -o "probecodex.pkg" "$PKG_URL"

  echo ""
  echo "📦 Running macOS installer..."
  echo "   (You may be prompted for your password)"
  echo ""

  # Use installer command for silent install (requires sudo)
  sudo installer -pkg "probecodex.pkg" -target /

  echo "✅ Installed to /usr/local/bin/"

else
  # Linux: Download and extract tar.gz
  ARCHIVE_URL="https://droidtech.ai/downloads/probecodex/$VERSION/probecodex-$PLATFORM.tar.gz"
  echo "📥 Downloading $ARCHIVE_URL..."
  curl -fsSL -o "probecodex.tar.gz" "$ARCHIVE_URL"

  echo "📂 Extracting..."
  tar -xzf "probecodex.tar.gz"

  # Install to ~/.probecodex/bin
  INSTALL_DIR="$HOME/.probecodex/bin"
  mkdir -p "$INSTALL_DIR"

  echo "📁 Installing to $INSTALL_DIR..."
  mv probecodex-*/probecodex-mcp "$INSTALL_DIR/"
  mv probecodex-*/probecodex-agent "$INSTALL_DIR/"
  chmod +x "$INSTALL_DIR/probecodex-mcp"
  chmod +x "$INSTALL_DIR/probecodex-agent"

  echo "✅ Binaries installed to $INSTALL_DIR"

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
fi

# Cleanup
cd /
rm -rf "$TEMP_DIR"

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "✅ ProbeCodex installed successfully!"
echo ""
echo "Next steps:"
if [ "$OS" = "Darwin" ]; then
  echo "  1. Binaries are in /usr/local/bin (already in PATH)"
else
  echo "  1. Open a new terminal (or run: export PATH=\"\$HOME/.probecodex/bin:\$PATH\")"
fi
echo "  2. Run the agent installer: probecodex-agent install"
echo ""
echo "The agent installer will:"
echo "  • Authenticate with your ProbeCodex account"
echo "  • Configure VPN (for Team/Enterprise)"
echo "  • Install dependencies (OpenOCD, etc.)"
echo "  • Set up the system service"
echo ""

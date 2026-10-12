#!/bin/bash
# Generic theme applicator
# Expects env vars:
#   THEME_NAME   - e.g. "catppuccin"
#   THEME_REPO   - git URL of the dotfiles repo

set -e
# Detect the real user's home (even when running under sudo)
if [ -n "$SUDO_USER" ]; then
  REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
  REAL_HOME="$HOME"
fi

echo "=== Applying theme: $THEME_NAME ==="

WORK_DIR="$HOME/.dcli-themes/$THEME_NAME"
BACKUP="$REAL_HOME/.config.dcli-backup"

# 1. Clone or update the repo
if [ -d "$WORK_DIR" ]; then
  echo "-> Updating existing repo..."
  cd "$WORK_DIR" && git pull
else
  echo "-> Cloning theme repo..."
  mkdir -p "$(dirname "$WORK_DIR")"
  git clone "$THEME_REPO" "$WORK_DIR"
fi

# 2. Backup existing configs (only first time)
BACKUP="$HOME/.config.dcli-backup"
if [ ! -d "$BACKUP" ]; then
  echo "-> Backing up current ~/.config to $BACKUP"
  cp -r "$HOME/.config" "$BACKUP"
fi

# 3. Try different install methods
cd "$WORK_DIR"

if [ -f "install.sh" ]; then
  echo "-> Running repo's install.sh..."
  bash install.sh

elif [ -f "setup.sh" ]; then
  echo "-> Running repo's setup.sh..."
  bash setup.sh

elif [ -d "config" ]; then
  echo "-> Copying config/ directory..."
  cp -rT config "$HOME/.config"

elif [ -d ".config" ]; then
  echo "-> Copying .config directory..."
  cp -rT .config "$HOME/.config"

else
  echo "⚠ No known install method found. Files are in $WORK_DIR"
  echo "  You may need to copy them manually."
fi

echo "=== Theme '$THEME_NAME' applied ==="

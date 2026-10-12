#!/bin/bash
set -e

# Detect the real user's home (even when running under sudo)
if [ -n "$SUDO_USER" ]; then
  REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
  REAL_HOME="$HOME"
fi

THEME_NAME="catppuccin"
THEME_REPO="https://github.com/CHANGE-ME/CHANGE-ME.git"

echo "=== Applying theme: $THEME_NAME ==="

WORK_DIR="$REAL_HOME/.dcli-themes/$THEME_NAME"
BACKUP="$REAL_HOME/.config.dcli-backup"

if [ -d "$WORK_DIR" ]; then
  echo "-> Updating existing repo..."
  cd "$WORK_DIR" && git pull
else
  echo "-> Cloning theme repo..."
  mkdir -p "$(dirname "$WORK_DIR")"
  git clone "$THEME_REPO" "$WORK_DIR"
fi

if [ -d "$WORK_DIR" ]; then
  echo "-> Updating existing repo..."
  cd "$WORK_DIR" && git pull
else
  echo "-> Cloning theme repo..."
  mkdir -p "$(dirname "$WORK_DIR")"
  git clone "$THEME_REPO" "$WORK_DIR"
  if [ -n "$SUDO_USER" ]; then
    chown -R "$SUDO_USER:$SUDO_USER" "$(dirname "$WORK_DIR")"
  fi
fi

cd "$WORK_DIR"

if [ -f "install.sh" ]; then
  echo "-> Running repo's install.sh..."
  bash install.sh
elif [ -f "setup.sh" ]; then
  echo "-> Running repo's setup.sh..."
  bash setup.sh
elif [ -d "config" ]; then
  echo "-> Copying config/ directory..."
  cp -rT config "$REAL_HOME/.config"
elif [ -d ".config" ]; then
  echo "-> Copying .config directory..."
  cp -rT .config "$REAL_HOME/.config"
else
  echo "Warning: No known install method found. Files are in $WORK_DIR"
fi

echo "=== Theme '$THEME_NAME' applied ==="

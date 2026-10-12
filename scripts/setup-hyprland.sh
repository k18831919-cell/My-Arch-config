#!/bin/bash
# This script sets up a Hyprland desktop with dotfiles from a Git repo.
set -e

# ============================================================
# CHANGE THIS URL to any dotfiles repo you want to use
# ============================================================
DOTS_REPO_URL="https://github.com/CHANGE-ME/CHANGE-ME.git"
DOTS_DIR="$HOME/.dotfiles-repo"

# ============================================================

echo "--- Cloning dotfiles from $DOTS_REPO_URL ---"
if [ -d "$DOTS_DIR" ]; then
  echo "Directory exists. Pulling latest changes..."
  cd "$DOTS_DIR" && git pull
else
  git clone "$DOTS_REPO_URL" "$DOTS_DIR"
fi

echo "--- Setting up dotfiles ---"
if [ -f "$DOTS_DIR/install.sh" ]; then
  echo "Found install.sh. Running it..."
  bash "$DOTS_DIR/install.sh"
elif [ -d "$DOTS_DIR/.config" ]; then
  echo "No install.sh found. Copying .config directory..."
  cp -rT "$DOTS_DIR/.config" "$HOME/.config"
else
  echo "Warning: No recognizable install method found in the repo."
  echo "Please check the repo structure and update this script."
fi

echo "--- Dotfile setup complete ---"

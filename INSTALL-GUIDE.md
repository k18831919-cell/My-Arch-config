# My CachyOS + Hyprland + dcli Setup Guide

## On a Fresh CachyOS Install

### 1. Install yay and dcli

    sudo pacman -S --needed yay base-devel
    yay -S --needed dcli

### 2. Clone your dcli recipes from GitHub

    dcli repo clone https://github.com/k18831919-cell/My-Arch-config.git

### 3. Enable your modules

    dcli module enable hyprland-desktop

### 4. Sync (installs packages + runs hooks)

    dcli sync

### 5. Reboot

    sudo reboot

---

## Managing Themes

### Enable a theme

    dcli module enable theme-tokyo-night
    dcli sync

### Switch themes

    dcli module disable theme-tokyo-night
    dcli module enable theme-catppuccin
    dcli sync

Only one theme can be enabled at a time (they conflict).

---

## Saving Changes Back to GitHub

After editing any module or script:

    cd ~/.config/dcli
    git add .
    git commit -m "describe your change"
    git push

### GitHub credentials

- Username: k18831919-cell
- Password: A Personal Access Token (NOT your account password)
- Generate token at: https://github.com/settings/tokens
- Scope needed: repo

---

## Emergency Recovery

If a theme breaks your desktop:

    rm -rf ~/.config
    mv ~/.config.dcli-backup ~/.config
    sudo reboot

---

## Module Reference

- hyprland-desktop: Base packages (Hyprland, Kitty, Dolphin, etc.)
- theme-tokyo-night: Tokyo Night theme from a Git repo
- theme-catppuccin: Catppuccin theme from a Git repo

---

## File Locations

- ~/.config/dcli/                  dcli workspace (git repo)
- ~/.config/dcli/modules/          Module YAML files
- ~/.config/dcli/scripts/          Hook scripts
- ~/.config/dcli/scripts/themes/   Per-theme scripts
- ~/.dcli-themes/                  Cloned theme repos (temporary)
- ~/.config.dcli-backup/           Config backup made by theme scripts

#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "==> Setting up dotfiles from $DOTFILES_DIR"

mkdir -p "$CONFIG_DIR"

# Target config items
ITEMS=(
    "hypr"
    "waybar"
    "swaync"
    "rofi"
    "wofi"
    "kitty"
    "cava"
    "fastfetch"
    "neofetch"
    "nwg-look"
    "xsettingsd"
    "gtk-3.0"
    "gtk-4.0"
    "gtkrc"
    "gtkrc-2.0"
)

for item in "${ITEMS[@]}"; do
    SRC="$DOTFILES_DIR/.config/$item"
    DEST="$CONFIG_DIR/$item"

    if [ -e "$SRC" ]; then
        if [ -e "$DEST" ] || [ -L "$DEST" ]; then
            # If it's already symlinked to the exact source, skip
            if [ "$(readlink -f "$DEST")" = "$(readlink -f "$SRC")" ]; then
                echo "  [OK] $item is already properly linked."
                continue
            fi

            # Backup existing non-matching target
            mkdir -p "$BACKUP_DIR"
            echo "  [BACKUP] Moving existing $DEST to $BACKUP_DIR/"
            mv "$DEST" "$BACKUP_DIR/"
        fi

        echo "  [LINK] Linking $SRC -> $DEST"
        ln -s "$SRC" "$DEST"
    fi
done

echo "==> Dotfiles setup complete!"

#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "==> Setting up dotfiles from $DOTFILES_DIR"

mkdir -p "$CONFIG_DIR"

# Target config items for ~/.config
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

# Link ~/.zshrc
if [ -e "$DOTFILES_DIR/.zshrc" ]; then
    DEST="$HOME/.zshrc"
    SRC="$DOTFILES_DIR/.zshrc"
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        if [ "$(readlink -f "$DEST")" != "$(readlink -f "$SRC")" ]; then
            mkdir -p "$BACKUP_DIR"
            echo "  [BACKUP] Moving existing $DEST to $BACKUP_DIR/"
            mv "$DEST" "$BACKUP_DIR/"
            echo "  [LINK] Linking $SRC -> $DEST"
            ln -s "$SRC" "$DEST"
        else
            echo "  [OK] .zshrc is already properly linked."
        fi
    else
        echo "  [LINK] Linking $SRC -> $DEST"
        ln -s "$SRC" "$DEST"
    fi
fi

echo "==> Dotfiles setup complete!"

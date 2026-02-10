#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"
BACKUP="$HOME/.config.stow-backup"

mkdir -p "$DOTFILES" "$BACKUP"

move_cfg() {
    local src="$1"
    local pkg="$2"
    local dst="$DOTFILES/$pkg/.config/$src"

    if [[ ! -e "$CONFIG/$src" ]]; then
        return
    fi

    echo "→ Moving $src into $pkg"
    mkdir -p "$(dirname "$dst")"
    mv "$CONFIG/$src" "$dst"
}

move_file() {
    local file="$1"
    local pkg="xdg"
    local dst="$DOTFILES/$pkg/.config/$file"

    if [[ ! -f "$CONFIG/$file" ]]; then
        return
    fi

    echo "→ Moving file $file"
    mkdir -p "$(dirname "$dst")"
    mv "$CONFIG/$file" "$dst"
}

echo "Backing up existing ~/.config to $BACKUP"
cp -a "$CONFIG" "$BACKUP"

# Core configs
move_cfg cava cava
move_cfg fish fish
move_cfg fastfetch apps
move_cfg yazi apps
move_cfg vicinae apps

# Terminal / WM
move_cfg kitty kitty
move_cfg niri niri

# GTK / Qt
move_cfg gtk-3.0 gtk
move_cfg gtk-4.0 gtk
move_cfg qt5ct qt
move_cfg qt6ct qt

# Audio / system
move_cfg wireplumber wireplumber
move_cfg systemd systemd

echo "Finished"
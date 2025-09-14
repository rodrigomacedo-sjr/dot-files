#!/bin/bash

# Define the backup directory in the home folder
BACKUP_DIR=~/backup

# --- SCRIPT START ---
echo "Starting configuration backup..."

# Create the backup directory, -p ensures it doesn't fail if it already exists
mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/config" # Create a sub-folder for .config items

# --- Copying Files and Folders ---

# 1. WezTerm (single file)
echo "Backing up WezTerm..."
cp ~/.wezterm.lua "$BACKUP_DIR/"

# 2. Zsh (config file and Oh My Zsh framework)
echo "Backing up Zsh and Oh My Zsh..."
cp ~/.zshrc "$BACKUP_DIR/"
# Also copy the Oh My Zsh directory which contains themes and plugins
cp -r ~/.oh-my-zsh "$BACKUP_DIR/"


# 3. Neovim (entire folder)
echo "Backing up Neovim..."
cp -r ~/.config/nvim "$BACKUP_DIR/config/"

# 4. i3 Window Manager (entire folder)
echo "Backing up i3..."
cp -r ~/.config/i3 "$BACKUP_DIR/config/"

# 5. Picom compositor (config file)
echo "Backing up Picom..."
# Check for both common locations
if [ -f ~/.config/picom.conf ]; then
    cp ~/.config/picom.conf "$BACKUP_DIR/config/"
elif [ -d ~/.config/picom ]; then
    cp -r ~/.config/picom "$BACKUP_DIR/config/"
fi

# 6. Polybar (entire folder)
echo "Backing up Polybar..."
cp -r ~/.config/polybar "$BACKUP_DIR/config/"


# --- Finalization ---
echo ""
echo "✅ Backup complete!"
echo "All configs are saved in: $BACKUP_DIR"



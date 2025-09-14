#!/bin/bash

# A script to set up a new Ubuntu 24.04 machine with a predefined environment.
# WARNING: This script is intended for a fresh installation.
# It will back up and overwrite existing configuration files.

# --- SCRIPT START ---
echo "Starting environment setup..."

# --- 1. Install All Required Software ---
echo "Installing applications via apt..."

sudo apt update
sudo apt install -y i3 zsh neovim pavucontrol picom polybar curl git

# Install WezTerm using its official repository
echo "Adding WezTerm repository and installing..."
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install -y wezterm

echo "✅ All software installed."

# --- 2. Back Up Existing Configs and Restore Yours ---
echo "Backing up default configs and restoring from ~/backup..."

# Define source and backup directories
SOURCE_DIR=~/backup
CONFIG_SOURCE_DIR=~/backup/config
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EXISTING_BACKUP_DIR=~/.config_backup_$TIMESTAMP

mkdir -p "$EXISTING_BACKUP_DIR"
echo "Any existing configs will be moved to $EXISTING_BACKUP_DIR"

# Function to safely move a file/dir if it exists
move_if_exists() {
    if [ -e "$1" ]; then
        mv "$1" "$2"
    fi
}

# Restore configs, moving defaults out of the way first
move_if_exists ~/.wezterm.lua "$EXISTING_BACKUP_DIR/"
cp "$SOURCE_DIR/.wezterm.lua" ~/

move_if_exists ~/.zshrc "$EXISTING_BACKUP_DIR/"
cp "$SOURCE_DIR/.zshrc" ~/

move_if_exists ~/.config/nvim "$EXISTING_BACKUP_DIR/"
cp -r "$CONFIG_SOURCE_DIR/nvim" ~/.config/

move_if_exists ~/.config/i3 "$EXISTING_BACKUP_DIR/"
cp -r "$CONFIG_SOURCE_DIR/i3" ~/.config/

move_if_exists ~/.config/picom.conf "$EXISTING_BACKUP_DIR/"
move_if_exists ~/.config/picom "$EXISTING_BACKUP_DIR/"
cp -r "$CONFIG_SOURCE_DIR/picom"* ~/.config/

move_if_exists ~/.config/polybar "$EXISTING_BACKUP_DIR/"
cp -r "$CONFIG_SOURCE_DIR/polybar" ~/.config/

echo "✅ Your configurations have been restored."

# --- 3. Final Steps ---
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

echo ""
echo "🎉 --- SETUP COMPLETE! --- 🎉"
echo ""
echo "Next Steps:"
echo "1. Log out and log back in. At the login screen, click the gear icon and choose 'i3' as your session."
echo "2. Open Neovim (nvim). Your plugin manager (e.g., lazy.nvim) should start installing all your plugins automatically."
echo "3. Enjoy your replicated environment!"


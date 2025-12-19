# ~/.zprofile — sourced on login shells (zsh)
# Make PATH idempotent and include your bins
typeset -U path PATH
[ -d "$HOME/bin" ]         && path=("$HOME/bin" $path)
[ -d "$HOME/.local/bin" ]  && path=("$HOME/.local/bin" $path)
[ -d "/opt/nvim" ]         && path=("/opt/nvim" $path)
[ -d "$HOME/.bun/bin" ]    && path=("$HOME/.bun/bin" $path)
export PATH="${(j.:.)path}"

# Editors / terminal
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="wezterm"


--[[
  WezTerm Configuration File
  Author: Gemini
  Description: A clean, minimalistic dark theme with settings
               based on user preferences.
--]]

-- Pull in the WezTerm API for configuration
local wezterm = require 'wezterm'

-- This table will hold our final configuration settings
local config = {}

-- Use the config_builder, which is the modern and recommended way to configure.
if wezterm.config_builder then
  config = wezterm.config_builder()
end


--------------------------------------------------------------------------------
-- APPEARANCE: FONT, THEME, AND STYLE
--------------------------------------------------------------------------------

-- Set the window decorations to none, which is ideal for a tiling window manager like i3.
config.window_decorations = "NONE"

-- Font configuration, as requested.
config.font = wezterm.font_with_fallback({
  'CaskaydiaCove Nerd Font Mono',
  'Noto Color Emoji', -- Fallback font for colorful emoji support
})
config.font_size = 12.0

-- Set the color scheme.
config.color_scheme = 'Catppuccin Mocha'

-- Window background transparency. The blur effect is handled by your
-- system's compositor (e.g., Picom), not WezTerm on Linux.
config.window_background_opacity = 0.92

-- Hide the tab bar when you only have one tab for a cleaner look.
config.hide_tab_bar_if_only_one_tab = true

-- Set padding to give your text some breathing room.
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 6,
}

-- Set the cursor style to a solid block, as requested.
config.default_cursor_style = 'BlinkingBlock'


--------------------------------------------------------------------------------
-- FUNCTIONALITY: KEYBINDINGS AND OTHER FEATURES
--------------------------------------------------------------------------------

-- Set the default shell to zsh.
config.default_prog = { '/usr/bin/zsh' }

-- Increase the number of scrollback lines.
config.scrollback_lines = 10000

-- Disable the audible bell, as requested.
config.audible_bell = "Disabled"

-- Disable the default WezTerm keybindings to prevent conflicts with i3.
config.disable_default_key_bindings = true

-- Define our own keybindings.
-- Note: The Ctrl+Shift+C binding for copy has been removed as requested.
config.keys = {
  -- Enable Ctrl+Shift+V for Pasting from the clipboard
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- Font size adjustments
  { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
}

-- Allow clicking on URLs to open them in your default browser.
config.hyperlink_rules = wezterm.default_hyperlink_rules()


-- Finally, return the configuration table
return config



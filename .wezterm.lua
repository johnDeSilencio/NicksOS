-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

-- Increase the scrollback in the terminal
config.scrollback_lines = 100000

-- Increase font size
config.font_size = 20.0

-- Change theme
config.color_scheme = "catppuccin-macchiato"

-- Hide window banner
config.window_decorations = "RESIZE"

-- Hide tab banner when not necessary
config.hide_tab_bar_if_only_one_tab = true

-- Return the configuration to wezterm
return config

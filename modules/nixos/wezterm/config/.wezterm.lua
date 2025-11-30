local wezterm = require("wezterm")
local config = {}

-- Configure window
config.hide_tab_bar_if_only_one_tab = true

-- Configure font
config.font = wezterm.font {
	family = "IntoneMono Nerd Font",
	weight = "Regular"
}

config.font_size = 20

-- Configure transparency
config.window_background_opacity = 0.90

config.colors = {
	selection_fg = "none",
	selection_bg = "rgba(50% 50% 50% 50%)",

	-- Configure color scheme
	-- From miasma: https://github.com/xero/miasma.nvim
	background = "#222222",
	foreground = "#c2c2b0",

	-- "Normal" colors in Alacritty
	ansi = {
		"#222222",
		"#685742",
		"#5f875f",
		"#b36d43",
		"#78824b",
		"#bb7744",
		"#c9a554",
		"#d7c483",
	},

	-- "Bright" colors in Alacritty
	brights = {
		"#666666",
		"#685742",
		"#5f875f",
		"#b36d43",
		"#78824b",
		"#bb7744",
		"#c9a554",
		"#d7c483",
	},

	indexed = { [16] = "#222222" },

	-- Copy mode colors
	copy_mode_active_highlight_fg = { Color = "none"},
	copy_mode_inactive_highlight_bg = { Color = "#c9a554" },
	copy_mode_inactive_highlight_fg = { Color = "none" },

	-- Quick select mode colors
	quick_select_label_bg = { Color = "#d7c483" },
	quick_select_label_fg = { Color = "#685742" },
	quick_select_match_bg = { Color = "#c9a554" },
	quick_select_match_fg = { Color = "#685742" },
}

return config

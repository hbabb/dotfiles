local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/usr/bin/zsh", "-l" }

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 10.0

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night Storm (Gogh)"

-- config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.audible_bell = "Disabled"

config.term = "xterm-256color"

return config

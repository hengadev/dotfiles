-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Font settings
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"Berkeley Mono",
	"nonicons",
})

config.font_size = 18

-- Colors mirror whichever nvim theme was last picked (via Telescope or the
-- wofi menu) - see ~/.config/theme-sync/set-theme.sh, which regenerates
-- nvim_palette.lua and touches this file to trigger a reload. Falls back to
-- a fixed scheme until the first theme pick generates that file.
local palette_ok, nvim_palette = pcall(dofile, wezterm.config_dir .. "/nvim_palette.lua")
if palette_ok then
	config.colors = nvim_palette
else
	config.color_scheme = "Sweet Eliverlara (Gogh)"
end

-- Appearance settings
config.hide_tab_bar_if_only_one_tab = true -- hide the bar, if only one tab, useful since I use tmux
config.use_fancy_tab_bar = false -- default is true, has more "native" look
config.enable_scroll_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Miscallenous settings
config.max_fps = 120
config.prefer_egl = true

-- and finally, return wezterm configuration
return config

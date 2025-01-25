-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Font settings
config.font = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'Berkeley Mono',
    'nonicons',
}

config.font_size = 19

-- default color scheme
-- wezterm.color_scheme = "Sweet Eliverlara (Gogh)"
config.color_scheme = "Sweet Eliverlara (Gogh)"

local theme_toggler = require("theme_toggler")
wezterm.on("toggle-dark-mode", theme_toggler.set(wezterm, "Sweet Eliverlara (Gogh)", "dark"))
wezterm.on("toggle-light-mode", theme_toggler.set(wezterm, "flexoki-light", "light"))
wezterm.on("window-config-reloaded", theme_toggler.watch_theme_file(wezterm))

config.keys = {
    -- theme manual switching
    { key = "1", mods = "CTRL", action = wezterm.action { EmitEvent = "toggle-light-mode" } },
    { key = "2", mods = "CTRL", action = wezterm.action { EmitEvent = "toggle-dark-mode" } },
}

-- Appearance settings
config.hide_tab_bar_if_only_one_tab = true -- hide the bar, if only one tab, useful since I use tmux
config.use_fancy_tab_bar = false           -- default is true, has more "native" look
config.enable_scroll_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Miscallenous settings
config.max_fps = 120
config.prefer_egl = true

-- and finally, return wezterm configuration
return config

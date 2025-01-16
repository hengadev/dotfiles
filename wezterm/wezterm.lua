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
wezterm.color_scheme = "Sweet Eliverlara (Gogh)"

-- Color settings
-- toggle light/dark scheme with CTRL+l (found this code here: https://github.com/wez/wezterm/discussions/1118)
wezterm.on("toggle-dark-mode", function(window)
    -- local light_scheme = "Rosé Pine Dawn (base16)"
    -- local dark_scheme = ""
    local light_scheme = "flexoki-light"
    local dark_scheme = "Sweet Eliverlara (Gogh)"
    local overrides = window:get_config_overrides() or {}
    wezterm.log_info("Current color scheme is: ", overrides.color_scheme)
    if (overrides.color_scheme == light_scheme)
    then
        wezterm.log_info("Setting to Dark Scheme: ", overrides.color_scheme)
        overrides.color_scheme = dark_scheme
    else
        wezterm.log_info("Setting to Light ", overrides.color_scheme)
        overrides.color_scheme = light_scheme
    end
    window:set_config_overrides(overrides)
end)

config.keys = {
    { key = "l", mods = "CTRL", action = wezterm.action { EmitEvent = "toggle-dark-mode" } },
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

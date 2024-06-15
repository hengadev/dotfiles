-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set background to same color as neovim
-- config.colors = {}
-- config.colors.background = '#111111'
config.color_scheme = 'Rosé Pine (base16)'


config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font',
  'Berkeley Mono',
  'nonicons',
}

config.font_size = 12.5

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
local padding = 10
config.window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config

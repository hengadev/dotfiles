-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.colors = {}
-- config.colors.background = '#111111'

-- toggle light/dark scheme with CTRL+l (found this code here: https://github.com/wez/wezterm/discussions/1118)
wezterm.on("toggle-dark-mode", function(window,pane)
  local light_scheme = "Builtin Solarized Light"
  local dark_scheme = "Rosé Pine (base16)"
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
    {
        key="l", mods="CTRL", action=wezterm.action{EmitEvent="toggle-dark-mode"},
    },
}


-- hide the bar, if only one tab, useful since I use tmux
config.hide_tab_bar_if_only_one_tab = true


config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font',
  'Berkeley Mono',
  'nonicons',
}

-- TODO: change that depending on the screen you  use
-- config.font_size = 16.5
config.font_size = 18

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config

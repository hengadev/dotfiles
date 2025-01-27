local config = require "nvconfig"
local get_theme_tb = require("base46").get_theme_tb
local colors = get_theme_tb "base_30"
local generate_color = require("base46.colors").change_hex_lightness

local statusline_bg = config.base46.transparency and "NONE" or colors.statusline_bg
local light_grey = generate_color(colors.light_grey, 8)

-- TODO:
-- get the current theme
-- set the theme based on that thing using: https://github.com/nvim-lualine/lualine.nvim/blob/2a5bae925481f999263d6f5ed8361baef8df4f83/examples/evil_lualine.lua
-- add a reload function to help reload the lualine theme once I make change with the base46 telescope extension

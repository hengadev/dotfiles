local get_section_config = function(section)
    return require("plugins.ui.lualine.lualine_" .. section)
end

-- local sections = {}
-- for _, v in pairs({ "a", "b" }) do
--     sections["lualine_" .. v] = get_section_config(v)
-- end

-- return {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     dependencies = { "NvChad/base46" }, -- it depend on this plugins for the color theme
--     opts = function()
--         return {
--             options = {
--                 theme = "auto",
--                 -- TODO: get the base46 theme in here, will you ?
--                 -- theme = {
--                 --     normal = { fg = colors.fg, bg = colors.bg },
--                 --     inactive = { fg = colors.fg, bg = colors.bg },
--                 -- },
--                 globalstatus = true,
--                 disabled_filetypes = { statusline = { "dashboard", "alpha" } },
--                 section_separators = { left = '', right = '' },
--                 component_separators = { left = '', right = '' },
--             },
--             sections = {
--                 lualine_a = get_section_config("a"),
--                 lualine_b = get_section_config("b"),
--                 lualine_c = get_section_config("c"),
--                 lualine_x = get_section_config("x"),
--                 lualine_y = get_section_config("y"),
--                 lualine_z = get_section_config("z"),
--             },
--             -- TODO: maybe do a neogit extension, if I find time to do it.
--             extensions = {
--                 "lazy",
--                 "oil",
--                 "mason",
--                 "nvim-dap-ui",
--                 "toggleterm",
--                 "quickfix",
--                 "man",
--                 "trouble",
--             },
--         }
--     end,
-- }

return {}

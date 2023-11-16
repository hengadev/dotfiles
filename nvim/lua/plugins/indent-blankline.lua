-- local M = {
-- "lukas-reineke/indent-blankline.nvim",
-- version = "2.20.8",
-- event = "BufReadPre",
-- 	opts = {
-- 		space_char_blankline = " ",
-- 		show_current_context = true,
-- 		show_current_context_start = true,
-- 		filetype_exclude = {
-- 			"coc-explorer",
-- 			"dashboard",
-- 			"floaterm",
-- 			"alpha",
-- 			"help",
-- 			"packer",
-- 			"NvimTree",
-- 		},
-- 	},
-- }
--
-- return M

local M = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        filetype_exclude = {
            "coc-explorer",
            "dashboard",
            "floaterm",
            "alpha",
            "help",
            "packer",
            "NvimTree",
        },
    }
}
return M

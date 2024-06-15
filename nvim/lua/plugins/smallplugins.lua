-- A collection a small plugins that makes the editor more pleasant to use
return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			-- TODO: Change that to only css, and associated files ?
			filetypes = { "*" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue or blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				tailwind = true,
				virtualtext = "■",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{
				"gcc",
				mode = "n",
				"<Plug>(comment_toggle_linewise_current)",
			},
			{
				"gcc",
				mode = "x",
				"<Plug>(comment_toggle_linewise_visual)",
			},
			{
				"gbc",
				mode = "n",
				"<Plug>(comment_toggle_blockwise_current)",
			},
			{
				"gbc",
				mode = "x",
				"<Plug>(comment_toggle_blockwise_visual)",
			},
		},
		opts = {
			mappings = {
				basic = false,
				extra = false,
			},
		},
	},
	{
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
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "[S]earch [T]odo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "[S]earch [T]odo/Fix/Fixme" },
        },
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndo tree" } },
		},
	},
	-- Config qui vient de : https://raw.githubusercontent.com/alpha2phi/modern-neovim/main/lua/plugins/toggleterm.lua
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ [[<C-\>]] },
			{ "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
		},
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			size = 20,
			hide_numbers = true,
			open_mapping = [[<C-\>]],
			shade_filetypes = {},
			shade_terminals = false,
			shading_factor = 0.3,
			start_in_insert = true,
			persist_size = true,
			direction = "float",
			winbar = {
				enabled = false,
				name_formatter = function(term)
					return term.name
				end,
			},
		},
	},
}

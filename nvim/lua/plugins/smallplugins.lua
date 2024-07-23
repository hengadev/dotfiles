-- A collection a small plugins that makes the editor more pleasant to use
local makeKey = require("utils.makeKey")

SetCommentKey = makeKey("Comment")
SetTodoKey = makeKey("Todo")
SetUndoKey = makeKey("Undo")
SetTerminalKey = makeKey("Terminal")

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
			SetCommentKey( "gcc", "<Plug>(comment_toggle_linewise_current)", "Comment the current line", "n"),
			SetCommentKey( "gcc", "<Plug>(comment_toggle_linewise_visual)", "Comment the current line", "x"),
			SetCommentKey( "gbc", "<Plug>(comment_toggle_blockwise_current)", "Comment the current block", "n"),
			SetCommentKey( "gbc", "<Plug>(comment_toggle_blockwise_visual)", "Comment the current block","x"),
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
			-- space_char_blankline = " ",
			-- show_current_context = true,
			-- show_current_context_start = true,
			-- filetype_exclude = {
			-- 	"coc-explorer",
			-- 	"dashboard",
			-- 	"floaterm",
			-- 	"alpha",
			-- 	"help",
			-- 	"packer",
			-- 	"NvimTree",
			-- },
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
            SetTodoKey( "]t", function() require("todo-comments").jump_next() end, "Next todo comment"),
            SetTodoKey("[t", function() require("todo-comments").jump_prev() end, "Previous todo comment"),
            SetTodoKey( "<leader>xt", "<cmd>TodoTrouble<cr>", "Todo (Trouble)"),
            SetTodoKey( "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme (Trouble)" ),
            SetTodoKey("<leader>st", "<cmd>TodoTelescope<cr>", "[S]earch [T]odo" ),
            SetTodoKey("<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "[S]earch [T]odo/Fix/Fixme")
        },
	},
	{
		"mbbill/undotree",
		keys = {
			SetUndoKey( "<leader>u", vim.cmd.UndotreeToggle, "Toggle [U]ndo tree"),
		},
	},
	-- Config qui vient de : https://raw.githubusercontent.com/alpha2phi/modern-neovim/main/lua/plugins/toggleterm.lua
	{
		"akinsho/toggleterm.nvim",
		keys = {
			-- SetTerminalKey([[<C-\>]], "<Cmd>2ToggleTerm<Cr>", "Toggle window"),
			SetTerminalKey("<C-\\>", "<Cmd>2ToggleTerm<Cr>", "Toggle window"),
			SetTerminalKey("<leader>0", "<Cmd>2ToggleTerm<Cr>", "Toggle window #2"),
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

-- NOTE: The basic file for the NVChad theme config
local M = {}

M.ui = {
	------------------------------- base46 -------------------------------------
	-- hl = highlights
	hl_add = {},
	hl_override = {},
	changed_themes = {},
	-- TODO: Implement the toggle the nvchad functionnalities
	theme_toggle = { "radium", "decay", "tundra", "monochrome", "rosepine", "mountain", "nightowl", "oceanicnext" },
	-- theme = "onedark", -- default theme
	-- theme = "chadracula-evondev",
	-- theme = "pastelDark", -- default theme
    -- theme = "mountain", -- default theme
	theme = "tundra", -- default theme
	-- TODO: How to make sure that changing this files make the base46 using another theme, watch for the nvchad for that.
	--
	-- Rank for the themes:
	-- 1. tundra : pas ouf sur les rendus de html -> mais le theme de teej il y a deux ans
	-- 2. mountain : what looks like teej current theme (but use it only at night because it is very dark)
	-- 3. decay : une sorte de radium avec moins de rouge et moins aggro
	-- 4: rosepine (kind of a freak theme)
	-- 5. monochrome un theme tres pur et peu de contraste, du coup dur de voir si ecran a du soleil
	transparency = false,

	cmp = {
		icons = true,
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
	},

	-- telescope = { style = "borderless" }, -- borderless / bordered
	telescope = { style = "bordered" }, -- borderless / bordered

	------------------------------- nvchad_ui modules -----------------------------
	statusline = {
		theme = "default", -- default/vscode/vscode_colored/minimal
		-- default/round/block/arrow separators work only for default statusline theme
		-- round and block will work for minimal theme only
		separator_style = "default",
		order = nil,
		modules = nil,
	},

	-- lazyload it when there are 1+ buffers
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
	},

	-- NOTE: I do not use that one
	-- nvdash = {
	-- load_on_startup = false,
	-- header = {
	--     "           ▄ ▄                   ",
	--     "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
	--     "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
	--     "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
	--     "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
	--     "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
	--     "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
	--     "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
	--     "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
	-- },
	--     buttons = {
	--         { "  Find File", "Spc f f", "Telescope find_files" },
	--         { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
	--         { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
	--         { "  Bookmarks", "Spc m a", "Telescope marks" },
	--         { "  Themes", "Spc t h", "Telescope themes" },
	--         { "  Mappings", "Spc c h", "NvCheatsheet" },
	--     },
	-- },

	cheatsheet = { theme = "grid" }, -- simple/grid

	lsp = {
		signature = true,
		semantic_tokens = false,
	},

	term = {
		-- hl = "Normal:term,WinSeparator:WinSeparator",
		sizes = { sp = 0.3, vsp = 0.2 },
		float = {
			relative = "editor",
			row = 0.3,
			col = 0.25,
			width = 0.5,
			height = 0.4,
			border = "single",
		},
	},
}

M.base46 = {
	integrations = {
		"blankline",
		"cmp",
		"defaults",
		"devicons",
		"git",
		"lsp",
		"mason",
		"nvcheatsheet",
		"nvdash",
		"nvimtree",
		"statusline",
		"syntax",
		"treesitter",
		"tbline",
		"telescope",
		"whichkey",
	},
}

return M

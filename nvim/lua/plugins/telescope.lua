-- plugins
vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/andrewberty/telescope-themes",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

-- config
require("telescope").setup({
	pickers = {
		builtin = {
			theme = "ivy",
		},
		find_files = { -- Specify the custom finder to use when picking files
			theme = "ivy",
			find_command = {
				"rg",
				"--no-ignore",
				"--hidden",
				"--files",
				"-g",
				"!**/node_modules/*",
				"-g",
				"!**/.git/*",
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
	extensions_list = { "themes" },
})

pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "themes")

-- TODO: here is for the custom extension
-- local load_custom_extension = require("plugins.telescope.extensions")
-- load_custom_extension()

-- keymaps
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
-- <leader>sf, <leader>sg, <leader>sw, <leader>sv moved to fff.nvim, see plugins/fff.lua
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "[S]earch [R]eferences" })
vim.keymap.set("n", "<leader>si", builtin.lsp_document_symbols, { desc = "[S]earch [I]n-file Symbols" })
vim.keymap.set("n", "<leader>sy", builtin.lsp_dynamic_workspace_symbols, { desc = "[S]earch S[y]mbols (workspace)" })
vim.keymap.set("n", "<leader>sc", builtin.git_commits, { desc = "[S]earch [C]ommits" })
vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "[S]earch [B]ranches" })
vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "[S]earch [O]ld files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Enable Telescope extensions if they are installed
vim.keymap.set("n", "<leader>th", function()
	require("telescope").extensions.themes.themes_picker()
end, { desc = "[TH]eme Picker for Base46 themes" })

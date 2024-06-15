-- NOTE: this configuration comes from kickstart where I used my previous keymaps

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- NOTE: Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				find_files = {
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
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		---@params:desc string
		local helper_desc = function(desc)
			return "Telescope: " .. desc
		end

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = helper_desc("[S]earch [H]elp") })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = helper_desc("[S]earch [K]eymaps") })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = helper_desc("[S]earch [F]iles") })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = helper_desc("[S]earch [S]elect Telescope") })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = helper_desc("[S]earch current [W]ord") })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = helper_desc("[S]earch by [G]rep") })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = helper_desc("[S]earch [D]iagnostics") })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = helper_desc("[S]earch [R]esume") })
		vim.keymap.set(
			"n",
			"<leader>s.helper_desc( ",
			builtin.oldfiles,
			{ desc = '[S]earch Recent Files (" )." for repeat)' }
		)
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = helper_desc("[ ] Find existing buffers") })
		vim.keymap.set("n", "<leader>m", builtin.marks, { desc = helper_desc("[S]earch [M]arks") })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = helper_desc("[/] Fuzzily search in current buffer") })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = helper_desc("[S]earch [/] in Open Files") })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>nc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = helper_desc("[S]earch [N]eovim files") })
	end,
}

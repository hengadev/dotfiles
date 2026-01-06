-- Automatically stop idle LSP servers to save memory
return {
	"hinell/lsp-timeout.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	event = "LspAttach",
	opts = {
		-- Stop LSP servers after 15 minutes of inactivity (default: 30 mins)
		-- Adjust this based on your workflow - shorter = more memory savings
		-- but more frequent restarts
		stop_timeout = 1000 * 60 * 15, -- 15 minutes in milliseconds

		-- Callback when server stops (optional, for debugging)
		on_stop = function(client)
			-- vim.notify(string.format("LSP server %s stopped", client.name), vim.log.levels.INFO)
		end,

		-- Callback when server starts (optional, for debugging)
		on_start = function(client)
			-- vim.notify(string.format("LSP server %s started", client.name), vim.log.levels.INFO)
		end,

		-- Servers to exclude from auto-stopping (e.g., servers you always want running)
		-- Examples: lua_ls if you're always editing nvim config
		stop_timeout_exceptions = {
			-- "lua_ls",  -- Uncomment to keep lua_ls always running
		},
	},
}

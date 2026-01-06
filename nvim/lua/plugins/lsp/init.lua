local mason_cmd = "Mason"

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "saghen/blink.cmp" },
		{ "williamboman/mason.nvim", cmd = mason_cmd },
		{ "williamboman/mason-lspconfig.nvim", cmd = mason_cmd },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", cmd = mason_cmd },
		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer.
		local lsp_attach = require("plugins.lsp.attach_autocommand")
		lsp_attach()

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		local servers = require("plugins.lsp.servers")

		-- Ensure the servers and tools above are installed
		require("mason").setup()

		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Format Lua code
			"delve", -- Debugger for the go programming language
			"codelldb", -- A native debugger based on LLDB.
			"debugpy",
			"prettierd",
		})

		-- ◍ tailwindcss-language-server tailwindcss (keywords: css)
		-- ◍ terraform-ls terraformls (keywords: terraform)
		-- ◍ typescript-language-server ts_ls (keywords: typescript, javascript)

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					local capabilities = require("blink.cmp").get_lsp_capabilities()
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					lspconfig[server_name].setup(server)
				end,
			},
		})
	end,
}

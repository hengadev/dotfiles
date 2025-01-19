local mason_cmd = "Mason"

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'saghen/blink.cmp' },
        { "williamboman/mason.nvim",                   cmd = mason_cmd },
        { "williamboman/mason-lspconfig.nvim",         cmd = mason_cmd, event = { "BufReadPre", "BufNewFile" } },
        { "WhoIsSethDaniel/mason-tool-installer.nvim", cmd = mason_cmd, event = { "BufReadPre", "BufNewFile" } },
        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim",                         opts = {},       event = { "BufReadPre", "BufNewFile" } },
        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        {
            "folke/neodev.nvim",
            config = true,
            opts = {},
            event = { "BufReadPre", "BufNewFile" }
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer.
        local lsp_attach = require("plugins.lsp.attach_autocommand")
        lsp_attach()

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.

        -- NOTE: the old way with nvim cmp in case it does not work
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        local servers = require("plugins.lsp.servers")

        -- Ensure the servers and tools above are installed
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",   -- Format Lua code
            "delve",    -- Debugger for the go programming language
            "codelldb", -- A native debugger based on LLDB.        })
        })

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    lspconfig[server_name].setup(server)
                end,
            },
        })

        -- TODO: use blink to get the capabilities as set in the example
        -- local capabilities = require("blink.cmp").get_lsp_capabilities()
    end,
}

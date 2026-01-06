--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
return {
    taplo = {},
    gopls = {},
    pyright = {},
    clangd = {},
    rust_analyzer = {},
    ts_ls = {},
    -- svelte_language_server = {},
    svelte = {},
    docker_compose_language_service = {},
    dockerls = {},
    terraformls = {},
    tailwindcss = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    -- But for many setups, the LSP (`typescript_language_server`) will work just fine
    -- typescript_language_server = {},
    lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},

        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                diagnostics = {
                    disable = { "missing-fields" },
                    globals = { 'vim' },
                },
            },
        },
    },
}

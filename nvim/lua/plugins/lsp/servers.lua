--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
return {
    taplo = {},
    gopls = {
        settings = {
            gopls = {
                -- Reduce memory usage
                ["ui.diagnostic.analyses"] = {
                    unusedparams = false,
                    shadow = false,
                },
                ["ui.completion.usePlaceholders"] = false,
                codelenses = {
                    gc_details = false,
                    generate = false,
                    regenerate_cgo = false,
                    test = false,
                    tidy = false,
                    upgrade_dependency = false,
                    vendor = false,
                },
            },
        },
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    -- Limit analysis to open files for memory savings
                    diagnosticMode = "openFilesOnly",
                    typeCheckingMode = "basic", -- use "off" for even more savings
                },
            },
        },
    },
    clangd = {
        cmd = {
            "clangd",
            "--background-index=false", -- Disable background indexing
            "--clang-tidy=false", -- Disable clang-tidy for memory savings
            "--completion-style=bundled",
            "--header-insertion=never",
            "--limit-results=20",
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                -- Critical memory optimizations
                cargo = {
                    allFeatures = false,
                    loadOutDirsFromCheck = false,
                },
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" }, -- Don't check dependencies
                },
                procMacro = {
                    enable = false, -- Disable proc macros to save memory
                },
                diagnostics = {
                    disabled = { "unresolved-proc-macro" },
                },
                -- Limit completion items
                completion = {
                    limit = 20,
                },
            },
        },
    },
    ts_ls = {
        -- Limit TypeScript server memory
        init_options = {
            maxTsServerMemory = 2048, -- Limit to 2GB (adjust lower if needed)
        },
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = "none",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = false,
                    includeInlayFunctionLikeReturnTypeHints = false,
                    includeInlayEnumMemberValueHints = false,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = "none",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = false,
                    includeInlayFunctionLikeReturnTypeHints = false,
                    includeInlayEnumMemberValueHints = false,
                },
            },
        },
    },
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

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        -- Je rajoute nvim context car c'est un plugin interessant surtout sur les gros projets
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                -- Option par default a voir si je veux les modifier
                require 'treesitter-context'.setup {
                    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                    line_numbers = true,
                    multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
                    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                    -- Separator between context and content. Should be a single character string, like '-'.
                    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                    separator = nil,
                    zindex = 20,     -- The Z-index of the context window
                    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
                }
            end
        }
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "lua",
                "markdown",
                "markdown_inline",
                "bash",
                "html",
                "css",
                "javascript",
                -- "java",
                "rust",
                "cpp",
                "c",
                "yaml",
                "typescript",
                "json",
                "luap",
                "python",
                "tsx",
                "go",
            },
            sync_install = false,
            auto_install = true,
            autopairs = {
                enable = true,
            },
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = {
                enable = true,
            },
        }
    end,
}

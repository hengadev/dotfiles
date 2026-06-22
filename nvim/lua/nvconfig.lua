local M = {}
M.cheatsheet = { theme = "grid" }
M.ui = {
    ------------------------------- base46 -------------------------------------
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default",                -- default/flat_light/flat_dark/atom/atom_colored
    },
    telescope = { style = "borderless" }, -- borderless / bordered
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
        bufwidth = 21
    },

    nvdash = {
        load_on_startup = true,
        header = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        },
        buttons = {
            { "  Find File", "Spc f f", "Telescope find_files" },
            { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
            { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
            { "  Bookmarks", "Spc m a", "Telescope marks" },
            { "  Themes", "Spc t h", "Telescope themes" },
            { "  Mappings", "Spc c h", "NvCheatsheet" },
        },
    },

    -- cheatsheet = { theme = "grid" }, -- simple/grid

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
    theme = "midnight_breeze", -- default theme
    hl_add = {},
    hl_override = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = { "midnight_breeze", "midnight_breeze" },

    integrations = {
        "blankline",
        "cmp",
        "defaults",
        "devicons",
        "git",
        "lsp",
        "mason",
        "bufferline",
        "nvimtree",
        "treesitter",
        "telescope",
        "whichkey",
        "flash",
        -- NOTE: trying some integrations that I should have
        -- "nvim-dap",

        -- NOTE: integrations for nvchad that I do not have
        -- "statusline",
        -- "nvcheatsheet",
        -- "tbline",
        -- "syntax",
    },
}

return M

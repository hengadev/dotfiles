local M = {}

M.base46 = {
    theme = "midnight_breeze",
    theme_toggle = { "midnight_breeze", "midnight_breeze" },
    transparency = false,
    hl_add = {},
    hl_override = {},
    changed_themes = {},
    integrations = {},
    -- only keep the base46 integrations for plugins actually installed in this config;
    -- the rest (cmp/blink/mason/nvimtree/whichkey/...) index nvconfig fields we don't set
    -- and error out when compiled
    excluded = { "statusline", "blankline", "blink", "cmp", "mason", "nvcheatsheet", "nvimtree", "tbline", "whichkey" },
}

M.ui = {
    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        order = nil,
        modules = nil,
    },
}

return M

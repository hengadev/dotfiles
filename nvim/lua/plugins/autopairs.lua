-- plugins
vim.pack.add({
    "https://github.com/windwp/nvim-autopairs",
})

-- config
require("nvim-autopairs").setup({
    check_ts = true,
    -- TelescopePrompt/spectre_panel/snacks_picker_input are already disabled
    -- by default; fff's search input (filetype fff_input) isn't, so typing
    -- a "(" or "\"" into a find_files/live_grep query would otherwise
    -- insert a stray closing pair.
    disable_filetype = { "TelescopePrompt", "fff_input" },
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})

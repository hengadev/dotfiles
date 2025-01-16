-- Config vient de : https://raw.githubusercontent.com/alpha2phi/modern-neovim/main/lua/plugins/toggleterm.lua

local makeKey = require("utils.makeKey")
SetTerminalKey = makeKey("Terminal")

return {
    "akinsho/toggleterm.nvim",
    keys = {
        SetTerminalKey("<C-\\>", "<Cmd>2ToggleTerm<Cr>", "Toggle window"),
        SetTerminalKey("<leader>0", "<Cmd>2ToggleTerm<Cr>", "Toggle window #2"),
    },
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
        size = 20,
        hide_numbers = true,
        open_mapping = [[<C-\>]],
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = 0.3,
        start_in_insert = true,
        persist_size = true,
        direction = "float",
        winbar = {
            enabled = false,
            name_formatter = function(term)
                return term.name
            end,
        },
    },
}

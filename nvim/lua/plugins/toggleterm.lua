-- Config vient de : https://raw.githubusercontent.com/alpha2phi/modern-neovim/main/lua/plugins/toggleterm.lua

vim.pack.add({
    "https://github.com/akinsho/toggleterm.nvim",
})

vim.keymap.set({"n", "t"}, "<C-\\>", "<Cmd>2ToggleTerm<Cr>", {desc="Toggle window"})
vim.keymap.set("n", "<leader>0", "<Cmd>2ToggleTerm<Cr>", {desc="Toggle window #2"})

require("toggleterm").setup({
    size = 20,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    winbar = {
        enabled = false,
        name_formatter = function(term)
            return term.name
        end,
    },
})

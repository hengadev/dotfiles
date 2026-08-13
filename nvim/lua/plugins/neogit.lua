-- plugins
vim.pack.add({
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

-- config
require("neogit").setup({})

-- keymaps
vim.keymap.set("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "[G]it status" })
vim.keymap.set("n", "<leader>gc", "<Cmd>Neogit commit<CR>", { desc = "[G]it [C]ommit" })
vim.keymap.set("n", "<leader>gp", "<Cmd>Neogit pull<CR>", { desc = "[G]it [P]ull" })
vim.keymap.set("n", "<leader>gP", "<Cmd>Neogit push<CR>", { desc = "[G]it [P]ush" })

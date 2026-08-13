-- vim-dadbod-ui has no lua/ dir at all - it's configured purely through
-- g: globals read once when its plugin/db_ui.vim sources, so these must be
-- set before vim.pack.add() below (not passed to a .setup() call - there
-- isn't one).
vim.g.db_ui_use_nerd_fonts = 1

vim.pack.add({
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
})

vim.keymap.set("n", "<leader>bd", "<Cmd>DBUIToggle<CR>", { desc = "[D]atabase toggle UI" })

-- vim-dadbod-completion also has no general .setup() - only a blink.cmp
-- integration (lua/vim_dadbod_completion/blink.lua), which isn't installed
-- here. Without nvim-cmp/blink.cmp, its documented hookup is the built-in
-- omnifunc.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql", "sqlite", "mongo" },
    callback = function()
        vim.bo.omnifunc = "vim_dadbod_completion#omni"
    end,
})

-- NOTE: how to make connections :
-- sqlite:[filename] then name the connection

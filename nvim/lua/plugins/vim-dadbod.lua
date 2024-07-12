vim.keymap.set("n", "<leader>bd", "<Cmd>DBUIToggle<CR>", { silent = true, desc = "[D]atabase toggle vim-dadbod-ui" })

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = false },
        { "kristijanhusak/vim-dadbod-completion", ft = { 'sql', 'mysql', 'plsql', 'sqlite', 'mongo' }, lazy = false },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- the configuration for the db_ui
        vim.g.db_ui_use_nerd_font = 1
    end,
}

-- NOTE: how to make connections :
-- sqlite:[filename] then name the connection

local map = require("utils.helpers").set_prefix("Database")
map("<leader>bd", "<Cmd>DBUIToggle<CR>", "[D]atabase toggle UI")

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        {
            "tpope/vim-dadbod",
        },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { 'sql', 'mysql', 'plsql', 'sqlite', 'mongo' },
        },
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

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { 'sql', 'mysql', 'plsql', 'sqlite', 'mongo' }, lazy = true },
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

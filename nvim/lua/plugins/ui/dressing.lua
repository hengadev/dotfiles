local lazy = require("lazy")

return {
    -- better vim.ui
    {
        "stevearc/dressing.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                lazy.load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                lazy.load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

}

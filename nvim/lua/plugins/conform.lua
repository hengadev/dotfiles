return {
    'stevearc/conform.nvim',
    -- event = "BufWritePre",
    event = "InsertEnter",
    config = function()
        require("conform").setup({
            formatters_by_fmt = {
                lua = { "stylua", "lua_ls" },
                javascript = { "prettier" },
            },
            format_on_save = {
                timeout = 500,
                lsp_format = "fallback",
            },
        })
    end
}
-- for the rest of the configuration for the formatter just look at : https://github.com/ProgrammingRainbow/NvChad-2.5/blob/76620574ba342f6f86939e92cfbc4083cb4f42d2/lua/configs/conform.lua

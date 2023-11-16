
local M = {
    "numToStr/Comment.nvim",
    keys = {
        {
            "gcc",
            mode = "n",
            "<Plug>(comment_toggle_linewise_current)",
        },
        {
            "gcc",
            mode = "x",
            "<Plug>(comment_toggle_linewise_visual)",
        },
        {
            "gbc",
            mode = "n",
            "<Plug>(comment_toggle_blockwise_current)",
        },
        {
            "gbc",
            mode = "x",
            "<Plug>(comment_toggle_blockwise_visual)",
        },
    },
    opts = {
        mappings = {
            basic = false,
            extra = false,
        },
    },
}

return M

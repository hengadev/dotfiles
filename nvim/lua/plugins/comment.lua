local makeKey = require("utils.makeKey")

SetCommentKey = makeKey("Comment")
SetTodoKey = makeKey("Todo")

return {
    {
        "numToStr/Comment.nvim",
        keys = {
            SetCommentKey("gcc", "<Plug>(comment_toggle_linewise_current)", "Comment the current line", "n"),
            SetCommentKey("gcc", "<Plug>(comment_toggle_linewise_visual)", "Comment the current line", "x"),
            SetCommentKey("gbc", "<Plug>(comment_toggle_blockwise_current)", "Comment the current block", "n"),
            SetCommentKey("gbc", "<Plug>(comment_toggle_blockwise_visual)", "Comment the current block", "x"),
        },
        opts = {
            mappings = {
                basic = false,
                extra = false,
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPre", "BufNewFile" },
        config = true,
        -- stylua: ignore
        keys = {
            SetTodoKey("]t", function() require("todo-comments").jump_next() end, "Next todo comment"),
            SetTodoKey("[t", function() require("todo-comments").jump_prev() end, "Previous todo comment"),
            SetTodoKey("<leader>xt", "<cmd>TodoTrouble<cr>", "Todo (Trouble)"),
            SetTodoKey("<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme (Trouble)"),
            SetTodoKey("<leader>st", "<cmd>TodoTelescope<cr>", "[S]earch [T]odo"),
            SetTodoKey("<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "[S]earch [T]odo/Fix/Fixme")
        },
    },
}

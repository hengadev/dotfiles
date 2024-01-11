-- todo-comments

return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    -- TODO: integrer lam macro todo!()l dans les todos
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
        { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
        { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "[S]earch [T]odo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "[S]earch [T]odo/Fix/Fixme" },
    },

}

-- Example de toutes les todos
-- NOTE:
-- TODO:
-- FIX:
-- WARNING:
-- HACK:
-- PERF:
-- BUG:
-- TEST:

vim.opt.splitkeep = "screen"

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        bottom = {
            {
                ft = "toggleterm",
                size = { height = 0.2 },
            },
            { ft = "dap-repl", size = { height = 0.15 }, title = " Debug REPL" },
            { ft = "dapui_console", size = { height = 0.15 }, title = "Debug Console" },
        },
        right = {
            { ft = "dapui_scopes", title = " Scopes" },
            { ft = "dapui_watches", title = "󰂥 Watches" },
            { ft = "dapui_stacks", title = " Stacks" },
            { ft = "dapui_breakpoints", title = " Breakpoints" },
        },
    }
}

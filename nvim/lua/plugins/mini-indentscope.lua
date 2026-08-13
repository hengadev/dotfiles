-- plugins
vim.pack.add({
    "https://github.com/echasnovski/mini.indentscope",
})

-- config
require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
})

-- turn off the scope guide in buffers with no meaningful indent structure
-- to trace (special/UI buffers rather than source files)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "oil",
        "toggleterm",
        "NeogitStatus",
        "NeogitCommitMessage",
        "dap-repl",
        "dapui_scopes",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_console",
    },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

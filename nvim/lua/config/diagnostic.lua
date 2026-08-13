local signs = {
    Error = "✖ ",
    Warn = "! ",
    Hint = "󰌶 ",
    Info = " ",
}

local messages = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
}

vim.diagnostic.config({
    virtual_lines = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "WarnMsg",
        },
        texthl = messages,
        numhl = messages,
    },
    update_in_insert = true,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        })
    end,
})

local signs = require("utils").lsp_signs

local diagnosticMsg = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
}

vim.diagnostic.config({
    virtual_text = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        -- source = "always",
        source = true,
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'WarnMsg',
        },
        texthl = diagnosticMsg,
        numhl = diagnosticMsg,
    },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
    end,
})

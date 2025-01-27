local signs = require("utils.diagnostics.signs")

local messages = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
}

return {
    virtual_text = true,
    -- virtual_lines = true,
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
        texthl = messages,
        numhl = messages,
    },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}

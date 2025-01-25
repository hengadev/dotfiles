return function()
    local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
end

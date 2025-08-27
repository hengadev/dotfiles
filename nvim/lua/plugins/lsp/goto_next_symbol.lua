local M = {}

-- Helper: flatten nested document symbols
local function flatten_symbols(items, acc)
    for _, s in ipairs(items) do
        if s.range then
            table.insert(acc, s)
        end
        if s.children then
            flatten_symbols(s.children, acc)
        end
    end
end

-- Jump to next symbol
function M.goto_next_symbol()
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(_, result, _, _)
        if not result or vim.tbl_isempty(result) then return end

        local symbols = {}
        flatten_symbols(result, symbols)

        table.sort(symbols, function(a, b)
            return a.range.start.line < b.range.start.line
        end)

        local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
        for _, s in ipairs(symbols) do
            if s.range.start.line > curr_line then
                vim.api.nvim_win_set_cursor(0, { s.range.start.line + 1, s.range.start.character })
                return
            end
        end

        -- wrap around to the first symbol
        local first = symbols[1]
        vim.api.nvim_win_set_cursor(0, { first.range.start.line + 1, first.range.start.character })
    end)
end

-- Jump to previous symbol
function M.goto_prev_symbol()
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(_, result, _, _)
        if not result or vim.tbl_isempty(result) then return end

        local symbols = {}
        flatten_symbols(result, symbols)

        table.sort(symbols, function(a, b)
            return a.range.start.line < b.range.start.line
        end)

        local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
        for i = #symbols, 1, -1 do
            local s = symbols[i]
            if s.range.start.line < curr_line then
                vim.api.nvim_win_set_cursor(0, { s.range.start.line + 1, s.range.start.character })
                return
            end
        end

        -- wrap around to the last symbol
        local last = symbols[#symbols]
        vim.api.nvim_win_set_cursor(0, { last.range.start.line + 1, last.range.start.character })
    end)
end

return M

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

-- Helper: navigate to a symbol in a given direction
local function navigate_symbols(direction)
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(_, result, _, _)
        if not result or vim.tbl_isempty(result) then
            vim.notify("No symbols found in buffer", vim.log.levels.INFO)
            return
        end

        local symbols = {}
        flatten_symbols(result, symbols)

        table.sort(symbols, function(a, b)
            return a.range.start.line < b.range.start.line
        end)

        local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
        local target_symbol = nil

        if direction == "next" then
            for _, s in ipairs(symbols) do
                if s.range.start.line > curr_line then
                    target_symbol = s
                    break
                end
            end
            -- wrap around to the first symbol
            if not target_symbol then
                target_symbol = symbols[1]
            end
        else -- direction == "prev"
            for i = #symbols, 1, -1 do
                local s = symbols[i]
                if s.range.start.line < curr_line then
                    target_symbol = s
                    break
                end
            end
            -- wrap around to the last symbol
            if not target_symbol then
                target_symbol = symbols[#symbols]
            end
        end

        if target_symbol then
            vim.api.nvim_win_set_cursor(0, { target_symbol.range.start.line + 1, target_symbol.range.start.character })
        end
    end)
end

-- Jump to next symbol
function M.goto_next_symbol()
    navigate_symbols("next")
end

-- Jump to previous symbol
function M.goto_prev_symbol()
    navigate_symbols("prev")
end

return M

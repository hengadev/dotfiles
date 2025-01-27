local diagnosticsIcons = require("utils.diagnostics.signs")

local stbufnr = function()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

-- get that thing from data brother
-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvim/"
-- local colors = require("base46.integrations.statusline")

-- TODO: do some configuration to be able to choose with the value that I want for the type of lualine (default etc...)
-- local colors = require(vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/integrations/statusline/default"))
local colors = require("base46.integrations.statusline.default")
print("the color for the diag error is:", colors.St_lspError)

return {
    {
        "diagnostics",
        symbols = {
            error = diagnosticsIcons.Error,
            warn = diagnosticsIcons.Warn,
            info = diagnosticsIcons.Info,
            hint = diagnosticsIcons.Hint,
        },
        -- TODO: make that thing work
        diagnostics_color = {
            error = { fg = colors.St_lspError.fg, bg = colors.St_lspError.bg },
            warn = { fg = colors.St_lspWarning.fg, bg = colors.St_lspWarning.bg },
            info = { fg = colors.St_LspInfo.fg, bg = colors.St_LspInfo.bg },
            hint = { fg = colors.St_LspHints.fg, bg = colors.St_LspHints.bg },
        },
        padding = { left = 1, right = 0 },
    },
    {
        function()
            if rawget(vim, "lsp") then
                for _, client in ipairs(vim.lsp.get_clients()) do
                    if client.attached_buffers[stbufnr()] then
                        -- return (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
                        return (vim.o.columns > 100 and "   " .. client.name .. " ") or "   "
                    end
                end
            end

            return ""
        end,
        padding = { left = 0, right = 0 },
        color = { gui = "bold" }
    }
}

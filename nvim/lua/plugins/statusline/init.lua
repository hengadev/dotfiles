local M = {}
local config = require("nvconfig")

local function setup_statusline()
    local highlights = require("base46.integrations.statusline." .. config.ui.statusline.theme)

    for name, val in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, val)
    end

    vim.opt.laststatus = 3
    vim.o.statusline = "%!v:lua.require('plugins.statusline." .. config.ui.statusline.theme .. "')()"
    require("plugins.statusline.utils").autocmds()
end

setup_statusline()

vim.api.nvim_create_autocmd("User", {
    pattern = "NvThemeReload",
    callback = setup_statusline,
})

return M

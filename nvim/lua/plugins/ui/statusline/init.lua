local M = {}
local config = require("nvconfig")

local function setup_statusline()
    -- Get highlight groups
    local highlights = require("base46.integrations.statusline." .. config.ui.statusline.theme)

    -- Apply the highlight groups
    for name, val in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, val)
    end

    vim.opt.laststatus = 3
    vim.o.statusline = "%!v:lua.require('plugins.ui.statusline." .. config.ui.statusline.theme .. "')()"
    require("plugins.ui.statusline.utils").autocmds()
end

-- Initial setup
setup_statusline()

-- Setup autocmd for theme reloads
vim.api.nvim_create_autocmd("User", {
    pattern = "NvThemeReload",
    callback = setup_statusline
})

return M

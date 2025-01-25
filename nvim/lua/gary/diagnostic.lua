local utils = require("utils.diagnostics")

vim.diagnostic.config(utils.config)

vim.api.nvim_create_autocmd("CursorHold", {
    callback = utils.cursor_hold
})

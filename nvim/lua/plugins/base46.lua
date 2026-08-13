-- must be set before base46 is ever required
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- plugins
vim.pack.add({
    "https://github.com/NvChad/base46",
    -- base46 uses plenary.reload to hot-swap highlight modules on theme change
    "https://github.com/nvim-lua/plenary.nvim",
})

-- config
require("base46").load_all_highlights()

-- keymaps
vim.keymap.set("n", "<leader>tt", function()
    local nvconfig = require("nvconfig")
    local light, dark = nvconfig.base46.theme_toggle[1], nvconfig.base46.theme_toggle[2]
    nvconfig.base46.theme = (nvconfig.base46.theme == dark) and light or dark
    require("base46").load_all_highlights()
end, { desc = "[T]oggle light/dark [T]heme" })

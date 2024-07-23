local map = require("utils.map").set_prefix("LazyDocker")
map("<leader>ld", "<Cmd>LazyDocker<CR>", "Open menu")

return {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}

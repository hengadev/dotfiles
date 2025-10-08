local map = require("utils.helpers").set_prefix("LazyDocker")
map("<leader>ld", "<Cmd>Lazydocker<CR>", "Open menu")

return {
    -- "crnvl96/lazydocker.nvim",
    "mgierada/lazydocker.nvim",
    cmd = "Lazydocker",
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("lazydocker").setup({
            border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
        })
    end,
}

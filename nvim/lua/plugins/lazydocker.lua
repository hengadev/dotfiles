vim.keymap.set("n", "<leader>ld", "<Cmd>LazyDocker<CR>", { silent = true })

return {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}

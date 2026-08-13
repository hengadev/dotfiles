-- plugins
vim.pack.add({
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = vim.version.range("4.*"),
    }
})

-- config
require("nvim-surround").setup({
    keys = { "cs", "ds", "ys" },
})

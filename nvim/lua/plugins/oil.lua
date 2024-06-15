return {
    "https://github.com/stevearc/oil.nvim",
    lazy=false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            columns= {"icon"},
            keymaps= {
                ["<C-h>"] = false,
                ["<M-h>"] = "actions.select_split",
            },
            view_options = {
                show_hidden= true,
            }
        }
        -- Open parent directory in current window
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc= "Oil: Open parent directory"})
        -- Open parent directory in floating window
        vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
}

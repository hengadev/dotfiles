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
        local map = require("utils.map").set_prefix("Oil")
        map("-", "<CMD>Oil<CR>", "Open parent directory in current window")
        map("<leader>-", require("oil").toggle_float, "Open parent directory in floating window")
    end,
}

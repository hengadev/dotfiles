local map = require("utils.map").set_prefix("LazyGit")
map("<leader>lg", "<Cmd>LazyGit<CR>", "Open menu")

return {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").load_extension("lazygit")
    end,
}

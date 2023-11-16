return {
    "kdheepak/lazygit.nvim",
    -- NOTE: La seule option qu'il me fallait pour pouvoir launch lazy git a l'interieur de neovim
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").load_extension("lazygit")
    end,
}

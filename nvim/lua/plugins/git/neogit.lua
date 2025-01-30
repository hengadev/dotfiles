local makeKey = require("utils.makeKey")
SetNeogitKey = makeKey("Neogit")

return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
        { "nvim-lua/plenary.nvim",  event = { "BufRead" } }, -- required
        { "sindrets/diffview.nvim", event = { "BufRead" } }, -- optional - Diff integration
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        SetNeogitKey("<leader>gg", "<Cmd>Neogit<CR>", "Open menu"),
        SetNeogitKey("<leader>gc", "<Cmd>Neogit commit<CR>", "[C]ommit"),
        SetNeogitKey("<leader>gp", "<Cmd>Neogit pull<CR>", "[P]ull"),
        SetNeogitKey("<leader>gP", "<Cmd>Neogit push<CR>", "[P]ush"),
    },
    config = true
}

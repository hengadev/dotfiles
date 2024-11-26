local map = require("utils.map").set_prefix("Flash")
map("s", function() require("flash").jump() end, "Jump", { "n", "x", "o" })
map("S", function() require("flash").treesitter() end, "Flash Treesitter", { "n", "x", "o" })
map("r", function() require("flash").remote() end, "Remote Flash", { "o" })
map("R", function() require("flash").treesitter_search() end, "Treesitter Search", { "o", "x" })
map("<c-s>", function() require("flash").toggle() end, "Toggle Flash Search", { "c" })

-- je vais voir le truc

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
}

-- TODO: Do the setup for that, make a good register for it.
return {
    {
        "mrjones2014/legendary.nvim",
        keys = {
            { "<C-S-p>",    "<cmd>Legendary<cr>", desc = "Legendary" },
            { "<leader>hc", "<cmd>Legendary<cr>", desc = "Command Palette" },
        },
        opts = {
            which_key = { auto_register = true },
        },
    },
    {
        "folke/which-key.nvim",
        dependencies = {
            "mrjones2014/legendary.nvim",
        },
        -- the most recent versions causes the mapping to break...
        version="2.1.0",
        event = "VeryLazy",
        config = function()
            local wk = require "which-key"
            wk.setup {
                show_help = true,
                plugins = { spelling = true },
                key_labels = { ["<leader>"] = "SPC" },
                triggers = "auto",
                window = {
                    border = "single",        -- none, single, double, shadow
                    position = "bottom",      -- bottom, top
                    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
                    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0,
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3,                    -- spacing between columns
                    align = "left",                 -- align columns left, center or right
                },
            }
            wk.register({
                w = { "<cmd>update!<CR>", "Save" },
                -- stylua: ignore
                q = {
                    name = "Quit",
                    -- q = { function() require("utils").quit() end, "Quit", },
                    t = { "<cmd>tabclose<cr>", "Close Tab" },
                },
                c = { name = "+Command" },
                d = { name = "+Debug" },
                b = { name = "+Database",
                    d = { name = "Toggle DadBodUI menu" },
                },
                h = { name = "+Gitsigns" },
                g = { name = "+Git",
                    c = { name = "Commit" },
                    p = { name = "Pull" },
                    P = { name = "Push" },
                    b = { name = "Branches" }
                },
                n = { name = "+Notification" },
                r = { name = "+Harpoon",
                    a = { name = "Add file" },
                    o = { name = "Open menu" },
                    Ctrl1 = { name = "Navigate to file 1" },
                    Ctrl2 = { name = "Navigate to file 2" },
                    Ctrl3 = { name = "Navigate to file 3" },
                    Ctrl4 = { name = "Navigate to file 4" },
                },
                s = { name = "+Telescope",
                    f = { name = "File" },
                    g = { name = "Grep" },
                    s = { name = "Telescope" },
                    c = { name = "Commits" }
                },
                l = { name = "+Lazy",
                    g = { name = "Git" },
                    d = { name = "Docker" },
                    z = { name = "Lazy" }
                },
                -- stylua: ignore
            }, { prefix = "<leader>", mode = { "n", "v" } })
        end,
    },
}

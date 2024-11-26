local makeKey = require("utils.makeKey")
SetLegendaryKey = makeKey("Legendary")

-- NOTE: the site used to get the icons: https://www.nerdfonts.com/cheat-sheet

return {
    {
        "mrjones2014/legendary.nvim",
        keys = {
            SetLegendaryKey("<C-S-p>", "<cmd>Legendary<cr>", "Legendary" ),
            SetLegendaryKey("<leader>cp", "<cmd>Legendary<cr>", "Command Palette" ),
        },
        opts = {
            which_key = { auto_register = true },
        },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        win = {
            border = "single",        -- none, single, double, shadow
            -- position = "bottom",      -- bottom, top
            -- margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
            padding = { 1, 1 }, -- extra window padding [top, right, bottom, left]
            -- winblend = 0,
        },
        layout = {
            -- height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3,                    -- spacing between columns
            -- align = "left",                 -- align columns left, center or right
        },
        spec = {
            { "<leader>/", function()
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, desc = "Telescope search in current buffer", mode = "n" },
            { "<leader><leader>", require("telescope.builtin").buffers, desc="Telescope in existing buffers"},
            { "<leader>0", group = "+Terminal" },
            { "<leader>b", group = "+Database", icon="" },
            { "<leader>a", group = "+Avante", icon="" },
            { "<leader>g", group = "+Git"},
            { "<leader>d", group = "+Debug", icon=""},
            { "<leader>n", group = "+Notifications" },
            { "<leader>l", group = "+Lazy", icon="󰒲" },
            { "<leader>c", group = "+Custom", icon="󱁤" },
            { "<leader>s", group = "+Telescope" },
            { "<leader>t", group = "+Neotest", icon="󰙨" },
            { "<leader>r", group = "+Harpoon", icon="󰛢"},
            { "<leader>u", group = "+Undo", icon=""},
            { "<leader>m", group = "+Mason", icon="󱁤"},
            { "<leader>x", group = "+Todo", icon=""},
            { "<leader>-", require("oil").toggle_float, desc="Toggle Oil menu", icon = "󰏇" },
            { "<leader>?", icon = "" },
            { "<leader>ms", icon = "󱁤" },
            { "<leader>d", hidden="true" },
            { "<leader>p", hidden="true" },
            { "<leader>y", hidden="true" },
            { "<leader>Y", hidden="true" },
        },
      },
      keys = {
        {
            "<leader>?",
            function()
            require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
}

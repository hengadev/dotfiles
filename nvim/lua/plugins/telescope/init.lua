return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
        { "andrewberty/telescope-themes" },
    },
    config = function()
        -- NOTE: Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
        -- Opens a window that shows you all of the keymaps for the current Telescope picker.

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
            pickers = {
                builtin = {
                    theme = "ivy",
                },
                find_files = { -- Specify the custom finder to use when picking files
                    theme = "ivy",
                    find_command = {
                        "rg",
                        "--no-ignore",
                        "--hidden",
                        "--files",
                        "-g",
                        "!**/node_modules/*",
                        "-g",
                        "!**/.git/*",
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            extensions_list = { "themes" },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "themes")

        local set_builtin_keymaps = require("plugins.telescope.builtin_keymaps")
        set_builtin_keymaps()

        local load_custom_extension = require("plugins.telescope.extensions")
        load_custom_extension()
    end,
}

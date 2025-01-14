return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
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
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            pickers = {
                find_files = {
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
            -- extensions_list = {"themes",  "terms" },
            extensions_list = { "themes" },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "themes")

        local map = require("utils.map").set_prefix("Telescope")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        map("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
        map("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
        map("<leader>sf", builtin.find_files, "[S]earch [F]iles")
        map("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
        map("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
        map("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
        map("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
        map("<leader>sr", builtin.resume, "[S]earch [R]esume")
        map("<leader>sc", builtin.git_commits, "[S]earch [C]ommits")
        map("<leader>sb", builtin.git_branches, "[S]earch [B]ranches")
        map("<leader>so", builtin.oldfiles, "[S]earch [O]ld files")
        map("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
        map("<leader>sm", builtin.marks, "[S]earch [M]arks")

        -- Slightly advanced example of overriding default behavior and theme
        map("<leader>/", function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, "[/] Fuzzily search in current buffer")

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        map("<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, "[S]earch [/] in Open Files")

        -- Search Neovim configuration files
        map("<leader>sv", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, "[S]earch Neo[V]im configuration files")

        -- I need to use the extension that I declared
        map("<leader>th", function()
            require("telescope").extensions.themes.themes_picker()
        end, "Toggle [TH]eme Picker for NVChad themes")
    end,
}

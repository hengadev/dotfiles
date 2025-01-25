local map = require("utils.helpers").set_prefix("Telescope")

return function()
    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    map("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
    map("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
    map("<leader>sf", builtin.find_files, "[S]earch [F]iles")
    map("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
    map("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
    map("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
    map("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
    map("<leader>sr", builtin.lsp_references, "[S]earch [R]eferences")
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
end

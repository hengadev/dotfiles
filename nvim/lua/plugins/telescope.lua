-- telescope.nvim

return {
    'nvim-telescope/telescope.nvim',
    -- or                              , branch = '0.1.1',
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    keys = {
        -- Ceux la n'ont pas l'air de fonctionner
        {
            "<leader>?",
            "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
            desc =
            '[?] Find recently opened files',
        },
        {
            "<leader><space>",
            "<cmd>lua require('telescope.builtin').buffers()<cr>",
            desc =
            '[ ] Find existing buffers',
        },
        {
            "<leader>sk",
            "<cmd>lua require('telescope.builtin').keymaps()<cr>",
            desc =
            '[S]earch existing [K]eymaps',
        },
        -- La fonction que j'utiilise est assez moche, j'ai prefere la mettre dans le fichier utils que j'utilisais deja
        {
            "<leader>/",
            "<cmd>lua require('utils.telescope_utils').current_buffer_fuzzy_find() <cr>",
            desc =
            '[/] Fuzzily search in current buffer',
        },
        {
            "<leader>gf",
            "<cmd>lua require('telescope.builtin').git_files()<cr>",
            desc =
            "Search [G]it [F]iles ",
        },
        -- Les remaps commencant par s
        {
            "<leader>sf",
            "<cmd>lua require('telescope.builtin').find_files()<cr>",
            desc =
            '[S]earch [F]iles',
        },
        {
            "<leader>sh",
            "<cmd>lua require('telescope.builtin').help_tags()<cr>",
            desc =
            '[S]earch [H]elp',
        },
        {
            "<leader>sw",
            "<cmd>lua require('telescope.builtin').grep_string()<cr>",
            desc =
            '[S]earch Current [W]ord',
        },
        {
            "<leader>sg",
            "<cmd>lua require('telescope.builtin').live_grep()<cr>",
            desc =
            '[S]earch By [G]rep',
        },
        {
            "<leader>sd",
            "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
            desc =
            '[S]earch [D]iagnostics',
        },

        {
            "<leader>sm",
            "<cmd>lua require('telescope.builtin').marks()<cr>",
            desc =
            '[S]earch [M]arks',
        },

    }
}

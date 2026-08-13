-- plugins
vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
})

-- config
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- keymaps
local gs = package.loaded.gitsigns

vim.keymap.set({ "n", "v" }, "<leader>ga", gs.stage_hunk, { desc = "[G]it [A]dd" })
vim.keymap.set("n", "<leader>gs", gs.stage_buffer, { desc = "[G]it [S]tage" })
vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "[G]it [U]ndo stage" })
vim.keymap.set("n", "<leader>gw", gs.preview_hunk, { desc = "[G]it [P]review" })
vim.keymap.set("n", "<leader>gt", gs.toggle_current_line_blame, { desc = "[G]it [T]oggle line blame" })
vim.keymap.set("n", "[g", gs.prev_hunk, { desc = "Go to previous [G]it hunk" })
vim.keymap.set("n", "]g", gs.next_hunk, { desc = "Go to next [G]it hunk" })

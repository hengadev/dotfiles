return {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
        require("gitsigns").setup {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        }

        local gs = package.loaded.gitsigns
        -- local map = require("utils").map("Gitsigns")
        local map = require("utils.helpers").set_prefix("Gitsigns")

        -- getting branch name for gitsigns
        ---a helper function to help with getting the input of the branch name.
        local handle_diff_branch = function()
            local input = vim.fn.input("Branch to diff with")
            if input == "" then
                return
            end
            vim.cmd("<Cmd>Gvdiff " .. input)
        end

        map("<leader>ga", gs.stage_hunk, "[G]it [A]dd", { "n", "v" })
        map("<leader>gs", gs.stage_buffer, "[G]it [S]tage")
        map("<leader>gu", gs.undo_stage_hunk, "[G]it [U]ndo stage")
        map("<leader>gw", gs.preview_hunk, "[G]it [P]review")
        map("<leader>gt", gs.toggle_current_line_blame, "[G]it [T]oggle line blame")
        -- TODO: replace that with diff view since I do not have fugitive anymore
        -- map("<leader>gd", "<Cmd>Gvdiff<CR>", "[G]it [D]iff")
        -- map("<leader>gb", handle_diff_branch, "[G]it Diff [B]ranch")
        map("[g", gs.prev_hunk, "Go to previous [G]it")
        map("]g", gs.next_hunk, "Go to next [G]it")
    end
}

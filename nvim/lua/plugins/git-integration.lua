local makeKey = require("utils.makeKey")
SetNeogitKey = makeKey("Neogit")

return {
    {
        -- TODO: add the git worktree plugin from thePrimeAgen
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = {
            {"nvim-lua/plenary.nvim", event={"BufRead"}},         -- required
            {"sindrets/diffview.nvim", event={"BufRead"}},        -- optional - Diff integration
            "nvim-telescope/telescope.nvim",
        },
        keys = {
			SetNeogitKey("<leader>gg", "<Cmd>Neogit<CR>", "Open menu"),
			SetNeogitKey("<leader>gc", "<Cmd>Neogit commit<CR>", "Commit"),
			SetNeogitKey("<leader>gp", "<Cmd>Neogit pull<CR>", "Pull"),
			SetNeogitKey("<leader>gP", "<Cmd>Neogit push<CR>", "Push"),
        },
        config = true
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()

            require("gitsigns").setup{
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
            local map = require("utils.map").set_prefix("Gitsigns")

            -- getting branch name for gitsigns
            ---a helper function to help with getting the input of the branch name.
            local handle_diff_branch = function()
                local input = vim.fn.input("Branch to diff with")
                if input == "" then
                    return
                end
                vim.cmd("<Cmd>Gvdiff " .. input)
            end

            map("<leader>ha",gs.stage_hunk, "[H]unk [A]dd", {"n", "v"})
            map("<leader>hs",gs.stage_buffer, "[H]unk [S]tage")
            map("<leader>hu",gs.undo_stage_hunk, "[H]unk [U]ndo stage")
            map("<leader>hp",gs.preview_hunk, "[H]unk [P]review")
            map("<leader>ht", gs.toggle_current_line_blame, "[H]unk [T]oggle line blame")
            map("<leader>hd", "<Cmd>Gvdiff<CR>", "[H]unk [D]iff")
            map("<leader>hb", handle_diff_branch, "[H]unk Diff [B]ranch")
            map("[h", gs.prev_hunk, "Go to previous [H]unk")
            map("]h", gs.next_hunk, "Go to next [H]unk")
        end
    },
}

-- Ressources :
--     - https://github.com/rafi/vim-config/blob/master/lua/rafi/plugins/git.lua

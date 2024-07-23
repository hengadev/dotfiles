return {
    {
        "tpope/vim-fugitive",
        lazy=false,

        config = function()
            local map = require("utils.map").set_prefix("Fugitive")
            map("<leader>hw", "<Cmd>Gwrite<CR>", "[G]it [W]rite")
        end
    },
    {
        -- TODO: add the git worktree plugin from thePrimeAgen
    },
    {
        -- TODO: use of neogit instead of fugitive ?
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy=false,
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
            ---@params:
            local diffBranch = function()
                -- TODO: use telescope git branches to select the branch, so for that you need to require brother.
                local input = vim.fn.input("Branch to diff with")
                if input == "" then
                    return
                end
                -- todo: add a way to verify that input is in the list of branches of the project
                vim.cmd("<Cmd>Gvdiff " .. input)
            end

            map("<leader>hs",gs.stage_hunk, "[H]unk [S]tage", {"n", "v"})
            map("<leader>hp",gs.preview_hunk, "[H]unk [P]review")
            map("<leader>ht", gs.toggle_current_line_blame, "[H]unk [T]oggle line blame")
            map("<leader>hd", "<Cmd>Gvdiff<CR>", "[H]unk [D]iff")
            map("<leader>hb", diffBranch, "[H]unk Diff [B]ranch")
            map("[h", gs.prev_hunk, "Go to previous [H]unk")
            map("]h", gs.next_hunk, "Go to next [H]unk")
        end
    },
}

-- the function that he add to the thing are :
-- -Gwrite
-- -Gread
-- - Gblame

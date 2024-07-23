return {
    {
        "tpope/vim-fugitive",
        lazy=false,

        config = function()
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { desc = "Fugitive: " .. desc })
            end
            map("<leader>hw", ":Gwrite<CR>", "[G]it [W]rite")
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

            -- setting key maps for the plugin
            ---a helper function first to help with the writing of the description
            ---@params:desc string
            local map = function(keys, func, desc, modes)
                if modes == nil then
                    vim.keymap.set("n", keys, func, { desc = "Gitsigns: " .. desc })
                    return
                end
                for _, mode in pairs(modes) do
                    vim.keymap.set(mode, keys, func, { desc = "Gitsigns: " .. desc })
                end
            end

            -- getting branch name for gitsigns
            ---a helper function to help with getting the input of the branch name.
            ---@params:
            local diffBranch = function()
                local input = vim.fn.input("Branch to diff with")
                if input == "" then
                    return
                end
                -- todo: add a way to verify that input is in the list of branches of the project
                vim.cmd(":Gvdiff " .. input)
            end

            map("<leader>hs",gs.stage_hunk, "[G]it [S]tage hunk", {"n", "v"})
            map("<leader>hp",gs.preview_hunk, "[G]it [P]review")
            map("<leader>ht", gs.toggle_current_line_blame, "[G]it [T]oggle current line blame")
            map("<leader>hd", ":Gvdiff<CR>", "[G]it [D]iff")
            map("<leader>hb", diffBranch, "[G]it Diff [B]ranch")
            map("[h", gs.prev_hunk, "Go to previous [H]unk")
            map("]h", gs.next_hunk, "Go to next [H]unk")
        end
    },
}

-- the function that he add to the thing are :
-- -Gwrite
-- -Gread
-- - Gblame

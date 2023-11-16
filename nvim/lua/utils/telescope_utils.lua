local M = {}


-- C'est pas necessaire de le mettre ici surtout pour juste une fonction mais cela rend mieux en vrai
-- TODO: Faire en sorte de ne plus avoir le vim.treesiter deprecated en utilisant le leader /
function M.current_buffer_fuzzy_find()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end

return M

-- Je vais utiliser cette configuration pour C, C++ et rust bien qu'elle soit initialement prevu pour c++ et rust:w
--
local M = {}

function M.setup()
    local dap = require "dap"
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                -- NOTE: Precdente config que je ne prefere pas parce qu'il y a un input.
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')

                -- NOTE: Je pars du principe que la fonction est toujours dans le main. Mais surtout que je n'
                -- ai pas d'etape de linking a faire et donc que g++ -c et g++ donne le meme resultat.
                -- return vim.fn.getcwd() .. '/' .. 'main.o'
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            -- stopOnEntry = true,
        },
    }

    -- Je fais un specifique rust parce que je veux changer le path to executable
    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            -- On tente comme cela
            -- program = vim.fn.getcwd() .. 'target/debug' .. '${file}'
            cwd = '${workspaceFolder}',
            program = function()
                -- NOTE: Version precdente ou je devais valider l'input.
                -- return vim.fn.input('Path to executable:',
                --     vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
                return vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            end,
            stopOnEntry = false,
        },
    }
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        host = '127.0.0.1',
        -- port = 13000,
        executable = {
            -- CHANGE THIS to your path! Je garde au cas ou la forme preconise pour la commande
            -- command = '/absolute/path/to/codelldb/extension/adapter/codelldb',
            -- NOTE: Il faut modifier le path de codelldb en fonction de la machine que j'utilise, notamment apes le home
            command = '/home/henga/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
            args = { "--port", "${port}" },
        }
    }

    -- On utilise cette config pour C.
    dap.configurations.c = dap.configurations.cpp
end

return M

-- Ici on a la configuration du dap de python, qui est necessaire en vria
-- Trouve ici : https://www.reddit.com/r/neovim/comments/12gmm3c/in_kickstartnvim_how_to_add_python_debug/
local M = {}

function M.setup()
    local dap = require "dap"
    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = "/usr/bin/python3",
        }
    }

    dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
    }
end

return M

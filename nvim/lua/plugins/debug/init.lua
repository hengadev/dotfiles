return {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio", "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
        -- debuggers
        "leoluz/nvim-dap-go",
        -- "mfussenegger/nvim-dap-python",
        -- neotest
        "nvim-neotest/neotest",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- TODO: does not seem to work properly, make it work.
        require("nvim-dap-virtual-text").setup({})

        require("mason-nvim-dap").setup({
            automatic_setup = true,
            handlers = {},
            ensure_installed = {
                "delve",
                "codelldb",
                -- "python", -- I get a notification but it does not install the thing
            },
        })

        local ui = require("plugins.debug.ui")

        -- ui nvim-dap
        vim.fn.sign_define("DapBreakpoint", ui.dap.breakpoint)
        vim.fn.sign_define("DapBreakpointRejected", ui.dap.breakpoint_rejected)
        vim.fn.sign_define("DapStopped", ui.dap.stopped)
        vim.fn.sign_define("DapBreakpointCondition", ui.dap.breakpoint_condition)
        vim.fn.sign_define("DapLogPoint", ui.dap.log)
        -- TODO: need to add these signs
        -- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
        -- - `DapLogPoint` for log points (default: `L`)

        dap.set_log_level(ui.dap.log.level)

        -- ui nvim-dap-ui
        dapui.setup(ui.dapui)

        -- remap
        require("plugins.debug.remap")

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- language specific configuration
        -- lua

        -- go
        require("dap-go").setup()
        -- python
        -- require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        -- C, C++, rust
        dap.adapters.codelldb = {
            type = "executable",
            command = "/home/henga/.local/share/nvim/mason/bin/codelldb",
        }
        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.c
    end,
}

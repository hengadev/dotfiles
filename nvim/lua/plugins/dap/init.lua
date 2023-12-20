-- Shows how to use the DAP plugin to debug your code.

return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- From lazyvim
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
    },

    --         -- stylua: ignore
    keys = {
        {
            "<leader>dR",
            function() require("dap").run_to_cursor() end,
            desc =
            "Run to Cursor",
        },
        {
            "<leader>dE",
            function() require("dapui").eval(vim.fn.input "[Expression] > ") end,
            desc =
            "Evaluate Input",
        },
        {
            "<leader>dC",
            function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end,
            desc =
            "Conditional Breakpoint",
        },
        { "<leader>dU", function() require("dapui").toggle() end,   desc = "Toggle UI", },
        { "<leader>db", function() require("dap").step_back() end,  desc = "Step Back", },
        { "<leader>dc", function() require("dap").continue() end,   desc = "Continue", },
        { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
        {
            "<leader>de",
            function() require("dapui").eval() end,
            mode = { "n", "v" },
            desc =
            "Evaluate",
        },
        { "<leader>dg", function() require("dap").session() end,           desc = "Get Session", },
        {
            "<leader>dh",
            function() require("dap.ui.widgets").hover() end,
            desc =
            "Hover Variables",
        },
        { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
        { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into", },
        { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over", },
        { "<leader>dp", function() require("dap").pause.toggle() end,      desc = "Pause", },
        { "<leader>dq", function() require("dap").close() end,             desc = "Quit", },
        { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle REPL", },
        -- Il semblerait que j'euse un probleme ici, le probleme c'est que j'utilise deja la fonction continue
        { "<leader>ds", function() require("dap").continue() end,          desc = "Start debugger", },
        { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
        { "<leader>dx", function() require("dap").terminate() end,         desc = "Terminate debug session", },
        { "<leader>du", function() require("dap").step_out() end,          desc = "Step Out", },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                automatic_setup = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},
                -- You'll need to check that you have the required things installed online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    'delve',
                    'codelldb',
                    -- 'debugpy',
                },
            }
        }

        -- Je recuperes les utilitaires dans mon fichier utils
        local dap_utils = require('utils').dap_utils

        -- Le setup pour dap que je mets la parce que flemme d'organiser
        vim.fn.sign_define("DapBreakpoint", dap_utils.dap_builtin.breakpoint)
        vim.fn.sign_define("DapBreakpointRejected", dap_utils.dap_builtin.breakpoint_rejected)
        vim.fn.sign_define("DapStopped", dap_utils.dap_builtin.stopped)
        dap.set_log_level(dap_utils.dap_builtin.log.level)

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            -- TODO: A changer
            icons = { expanded = "", collapsed = "", circular = "" },
            controls = {
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "",
                    terminate = "",
                },
            },
            -- Je copie ce qui suit de Lunarvim
            -- Positionning of elements :
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {},
            expand_lines = true,
            layouts = {
                {
                    elements = {
                        { id = "scopes",      size = 0.33 },
                        { id = "breakpoints", size = 0.17 },
                        { id = "stacks",      size = 0.25 },
                        { id = "watches",     size = 0.25 },
                    },
                    size = 0.33,
                    position = "right",
                },
                {
                    elements = {
                        { id = "repl",    size = 0.45 },
                        { id = "console", size = 0.55 },
                        -- J'avais enleve la console sauf qu'il s'en trouve que j'en ai besoin en realite.
                        -- { id = "repl", size = 1 },
                    },
                    size = 0.30,
                    position = "bottom",
                },
                floating = {
                    max_height = 0.9,
                    max_width = 0.5, -- Floats will be treated as percentage of your screen.
                    border = "rounded",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                },
            },
            -- NOTE: Je viens de rajouter cela et je ne sais pas ce que cela fait
            opts = vim.tbl_extend("keep", opts or {}, {
                title = "dap-ui",
                icon = "",
                on_open = function(win)
                    vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
                end,
            }),

        }
        -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
        vim.keymap.set("n", "<F7>", dapui.toggle)

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- TODO: Rajouter les config des autres languages

        require('dap-go').setup()
        -- On install la configuration pour c, cpp et rust qui sont sur le meme fichier
        require("plugins.dap.cpp").setup()

        -- TODO: Rajouter la config python et lua
        require("plugins.dap.python").setup()
        -- Il me faut me connecter a un serveur je comprends pas trop la
        require("plugins.dap.lua").setup()
    end,
}

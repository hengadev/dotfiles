return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        -- debuggers
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            automatic_setup = true,
            handlers = {},
            ensure_installed = {
                "delve",
                "codelldb",
            },
        })

        local map = require("utils.map").set_prefix("Debug")
        map("<leader>hR", dap.run_to_cursor, "[D]ebug [R]un toCursor")
        map("<leader>hE", function() dapui.eval(vim.fn.input("[Expression] > ")) end, "[D]ebug[E]valuate Input")
        map("<leader>hC", function() dap.set_breakpoint(vim.fn.input("[Condition] > ")) end,
            "[D]ebug [C]onditional Breakpoint")
        map("<leader>hb", dap.step_back, "[D]ebug Step [B]ack")
        map("<leader>hc", dap.continue, "[D]ebug [C]ontinue")
        map("<leader>hd", dap.disconnect, "[D]ebug [D]isconnect")
        map("<leader>he", dapui.eval, "[D]ebug [E]valuate", { "n", "v" })
        map("<leader>hg", dap.session, "[D]ebug Get Session")
        map("<leader>hh", require("dap.ui.widgets").hover, "[D]ebug: [H]over Variables")
        map("<leader>hS", function() require("dap.ui.widgets").scopes() end, "[D]ebug [S]copes")
        map("<leader>hi", dap.step_into, "[D]ebug Step [I]nto")
        map("<leader>ho", dap.step_over, "[D]ebug Step [O]ver")
        map("<leader>hp", dap.pause, "[D]ebug [P]ause")
        map("<leader>hq", dap.close, "[D]ebug [Q]uit")
        map("<leader>hr", require("dap.repl").toggle, "[D]ebug Toggle [R]EPL")
        map("<leader>hs", dap.continue, "[D]ebug [S]tart debugger")
        map("<leader>ht", dap.toggle_breakpoint, "[D]ebug [T]oggle Breakpoint")
        map("<leader>hx", dap.terminate, "[D]ebug Terminate debug session")
        map("<leader>hu", dap.step_out, "[D]ebug Step Out")
        map("<leader>hU", dapui.toggle, "[D]ebug Toggle [U]I")

        -- Dap UI setup
        dapui.setup({
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
            opts = {
                title = "dap-ui",
                icon = "",
                on_open = function(win)
                    local name = string.format("%d", vim.api.nvim_win_get_buf(win))
                    vim.api.nvim_set_option_value(name, "filetype", { "markdown", "rust" })
                end,
                -- }),
            },
        })

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        map("<F7>", dapui.toggle, "Debug: See last session result.")

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- Install golang specific config
        require("dap-go").setup()
    end,
}

local M = {}

-- local Bug = ""
local Bug = ""

local BoldArrowRight = ""

M.dap = {
    active = true,
    on_config_done = nil,
    breakpoint = {
        text = Bug,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    },
    breakpoint_rejected = {
        text = Bug,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
    },
    breakpoint_condition = {
        text = "", -- pick any icon you like
        texthl = "DiagnosticSignInfo",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = BoldArrowRight,
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
    },
    log = {
        text = "",
        level = "info",
    },
}
M.dapui = {
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
    -- NOTE: this part is handled using "folke/edgy.nvim"
    -- layouts = {
    --     {
    --         elements = {
    --             { id = "scopes",      size = 0.33 },
    --             { id = "breakpoints", size = 0.17 },
    --             { id = "stacks",      size = 0.25 },
    --             { id = "watches",     size = 0.25 },
    --         },
    --         size = 0.33,
    --         position = "right",
    --     },
    --     {
    --         elements = {
    --             { id = "repl",    size = 0.45 },
    --             { id = "console", size = 0.55 },
    --             -- J'avais enleve la console sauf qu'il s'en trouve que j'en ai besoin en realite.
    --             -- { id = "repl", size = 1 },
    --         },
    --         size = 0.30,
    --         position = "bottom",
    --     },
    --     floating = {
    --         max_height = 0.9,
    --         max_width = 0.5, -- Floats will be treated as percentage of your screen.
    --         border = "rounded",
    --         mappings = {
    --             close = { "q", "<Esc>" },
    --         },
    --     },
    --     windows = { indent = 1 },
    --     render = {
    --         max_type_length = nil, -- Can be integer or nil.
    --         max_value_lines = 100, -- Can be integer or nil.
    --     },
    -- },
    opts = {
        title = "dap-ui",
        icon = "",
        on_open = function(win)
            local name = string.format("%d", vim.api.nvim_win_get_buf(win))
            vim.api.nvim_set_option_value(name, "filetype", { "markdown", "rust" })
        end,
    },
}

return M

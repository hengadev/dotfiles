-- plugins
vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/leoluz/nvim-dap-go",
})

-- config
local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup({})

-- dapui panels dock via edgy.nvim (see plugins/edgy.lua), so this stays
-- on the plugin's own defaults rather than a hand-rolled layout.
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointRejected", { text = "B", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticSignWarn", linehl = "Visual" })

-- go: handles the delve adapter/config on its own (expects `dlv` on PATH)
require("dap-go").setup()

-- c/c++/rust: expects `codelldb` on PATH (provision separately, same as LSP servers)
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

local codelldb_config = {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
}

dap.configurations.c = { codelldb_config }
dap.configurations.cpp = { codelldb_config }
dap.configurations.rust = { codelldb_config }

-- keymaps
vim.keymap.set("n", "<leader>ht", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle breakpoint" })
vim.keymap.set("n", "<leader>hc", dap.continue, { desc = "[D]ebug [C]ontinue / start" })
vim.keymap.set("n", "<leader>hi", dap.step_into, { desc = "[D]ebug step [I]nto" })
vim.keymap.set("n", "<leader>ho", dap.step_over, { desc = "[D]ebug step [O]ver" })
vim.keymap.set("n", "<leader>hu", dap.step_out, { desc = "[D]ebug step o[U]t" })
vim.keymap.set("n", "<leader>hr", dap.restart, { desc = "[D]ebug [R]estart" })
vim.keymap.set("n", "<leader>hx", dap.terminate, { desc = "[D]ebug terminate" })
vim.keymap.set("n", "<leader>hb", dap.run_to_cursor, { desc = "[D]ebug run to cursor" })
vim.keymap.set({ "n", "v" }, "<leader>he", dapui.eval, { desc = "[D]ebug [E]valuate" })
vim.keymap.set("n", "<leader>hU", dapui.toggle, { desc = "[D]ebug toggle [U]I" })

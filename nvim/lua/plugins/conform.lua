-- plugins
vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

-- config
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },
        go = { "gofmt", "goimports" },
        python = { "ruff_format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        sh = { "shfmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- keymaps
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[C]ode [F]ormat" })

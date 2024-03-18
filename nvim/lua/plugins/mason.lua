return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    opts = {
        ensure_installed = {
            "pyright",
            "codelldb",
            "typescript-language-server",
            "gopls",
            "rust-analyzer",
            "astro-language-server",
        },
    },
}

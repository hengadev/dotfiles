-- plugins
vim.pack.add({
    -- pinned to the 1.x line: v2 requires a separate "blink.lib" package
    -- and a manual build/download step that isn't worth the extra weight here.
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },
})

-- config
require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = true },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- give every LSP server blink.cmp's completion capabilities
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.enable({
    'lua_ls',
    'clangd',
    'gopls',
    'rust_analyzer',
    'ts_ls',
    'pyright',
    'svelte',
    'tailwindcss',
})

-- TODO: add the on attach autocommand for the LSPs in the right autocommand or in this file.

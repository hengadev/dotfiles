-- Pas grand chose dans ce fichier on va chercher quelque chose de plus complet
return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
}

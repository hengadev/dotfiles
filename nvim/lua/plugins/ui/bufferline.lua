-- TODO: still an issue with the background of the icons for some reason
return {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = 'tabs',
                -- available values are 'slant', 'padded_slant', 'thick',
                separator_style = 'slant',
                themable = true,
                -- NOTE: fix the icon background and then might turn that and the diagnostics to "nvim_lsp"
                show_buffer_icons = false,
                -- diagnostics = "nvim_lsp",

            }
        })
    end,
}

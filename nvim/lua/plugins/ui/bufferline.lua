-- here I need to change the color for that
return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        lazy = false,
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    mode = 'tabs',
                    show_buffer_icons = true,
                    themable = true,
                    separator_style = 'slant',
                }
            })
        end,
    }
}

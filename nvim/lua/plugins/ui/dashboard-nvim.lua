return {
    -- logo
    {
        'https://github.com/nvimdev/dashboard-nvim',
        event = "VimEnter",
        config = function()
            local dashboard = require("dashboard")
            local logo = [[
██╗  ██╗███████╗███╗   ██╗ ██████╗  █████╗
██║  ██║██╔════╝████╗  ██║██╔════╝ ██╔══██╗
███████║█████╗  ██╔██╗ ██║██║  ███╗███████║
██╔══██║██╔══╝  ██║╚██╗██║██║   ██║██╔══██║
██║  ██║███████╗██║ ╚████║╚██████╔╝██║  ██║
╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝
            ]]
            dashboard.setup({
                theme = 'doom',
                config = {
                    header = vim.split(string.rep("\n", 8) .. logo .. "\n\n", "\n"),
                    center = {
                        { icon = " ", desc = "Find File", action = "Telescope find_files" },
                        { icon = " ", desc = "Recent Files", action = "Telescope oldfiles" },
                        { icon = " ", desc = "Configuration", action = "e ~/.config/nvim/" },
                        { icon = " ", desc = "Quitter", action = "qa" },
                        -- Add more items as needed
                    },
                    footer = { "", "Time to get cracked !" }
                },
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    }
}

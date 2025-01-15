-- Je recupere ici tout l'ui de lazyvim dont je m'inspire on va pas se mentir

local makeKey = require("utils.makeKey")

SetNotifyKey = makeKey("Notify")
SetNoiceKey = makeKey("Noice")

return {
    -- {
    --     -- TODO: change that one for the snacks.nvim notifier
    --     "rcarriga/nvim-notify",
    --     event = "VeryLazy",
    --     keys = {
    --         SetNotifyKey("<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end,
    --             "[D]elete all [N]otifications"),
    --         SetNotifyKey("<leader>ns", function() require("telescope").extensions.notify.notify({}) end,
    --             "[S]earch all [N]otifications"),
    --     },
    --     opts = {
    --         timeout = 2000,
    --         max_height = function()
    --             return math.floor(vim.o.lines * 0.75)
    --         end,
    --         max_width = function()
    --             return math.floor(vim.o.columns * 0.65)
    --         end,
    --         -- render = "compact",
    --         stages = "fade",
    --         top_down = "false",
    --     },
    --     init = function()
    --         -- when noice is not enabled, install notify on VeryLazy
    --         local Util = require("utils")
    --         if not Util.has("noice.nvim") then
    --             Util.on_very_lazy(function()
    --                 vim.notify = require("notify")
    --             end)
    --         end
    --     end,
    -- },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = true },
        },
    },

    -- better vim.ui
    {
        "stevearc/dressing.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("utils")

            local function fg(name)
                return function()
                    ---@type {foreground?:number}?
                    local hl = vim.api.nvim_get_hl_by_name(name, true)
                    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
                end
            end

            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.lsp_signs.Error,
                                warn = icons.lsp_signs.Warn,
                                info = icons.lsp_signs.Info,
                                hint = icons.lsp_signs.Hint,
                            },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() return require("nvim-navic").get_location() end,
                            cond = function()
                                return package.loaded["nvim-navic"] and
                                    require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function()
                                return package.loaded["noice"] and
                                    require("noice").api.status.command.has()
                            end,
                            color = fg("Statement")
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = fg("Constant"),
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = fg("Special"),
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = { "neo-tree", "lazy" },
            }
        end,
    },

    -- active indent guide and indent text objects
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
        end,
    },

    -- noicer ui
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vimtrue.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            SetNoiceKey("<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, "Redirect Cmdline",
                "c"),
            SetNoiceKey("<leader>nl", function() require("noice").cmd("last") end, "[N]otification [L]ast Message"),
            SetNoiceKey("<leader>nh", function() require("noice").cmd("history") end, "[N]otification [H]istory"),
            SetNoiceKey("<leader>na", function() require("noice").cmd("all") end, "[N]otification [A]ll"),
            SetNoiceKey(
                "<c-f>",
                function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
                "Scroll forward",
                { "i", "n", "s" },
                true,
                true
            ),
            SetNoiceKey(
                "<c-b>",
                function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
                "Scroll backward",
                { "i", "n", "s" },
                true,
                true
            ),
        },
    },

    -- lsp symbol navigation for lualine
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            require("utils").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                icons = require("utils").lsp_kinds,
            }
        end,
    },

    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- ui components
    { "MunifTanjim/nui.nvim",        lazy = true },
    -- animations
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.scroll = {
                enable = false,
            }
        end
    },
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

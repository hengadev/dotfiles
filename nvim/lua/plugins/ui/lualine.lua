return {
    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local diagnosticsIcons = require("utils.diagnostics.signs")
            local gitIcons = require("utils.signs.git")

            local function fg(name)
                return function()
                    ---@type {foreground?:number}?
                    local hl = vim.api.nvim_get_hl_by_name(name, true)
                    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
                end
            end

            local navic = require("nvim-navic")
            local noice = require("noice")

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
                                error = diagnosticsIcons.Error,
                                warn = diagnosticsIcons.Warn,
                                info = diagnosticsIcons.Info,
                                hint = diagnosticsIcons.Hint,
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
                            function() return navic.get_location() end,
                            cond = function()
                                return package.loaded["nvim-navic"] and
                                    navic.is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return noice.api.status.command.get() end,
                            cond = function()
                                return package.loaded["noice"] and
                                    noice.api.status.command.has()
                            end,
                            color = fg("Statement")
                        },
                        -- stylua: ignore
                        {
                            function() return noice.api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and noice.api.status.mode.has() end,
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
                                added = gitIcons.added,
                                modified = gitIcons.modified,
                                removed = gitIcons.removed,
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
}

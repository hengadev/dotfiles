local makeKey = require("utils.makeKey")

SetNotifyKey = makeKey("Notify")
return {
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        keys = {
            SetNotifyKey("<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end,
                "[D]elete all [N]otifications"),
            SetNotifyKey("<leader>ns", function() require("telescope").extensions.notify.notify({}) end,
                "[S]earch all [N]otifications"),
        },
        opts = {
            timeout = 2000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.65)
            end,
            -- render = "compact",
            stages = "fade",
            top_down = "false",
        },
        init = function()
            -- when noice is not enabled, install notify on VeryLazy
            local Util = require("utils")
            if not Util.has("noice.nvim") then
                Util.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
    },
}

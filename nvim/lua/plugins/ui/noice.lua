local makeKey = require("utils.makeKey")
SetNoiceKey = makeKey("Noice")

return {
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
}

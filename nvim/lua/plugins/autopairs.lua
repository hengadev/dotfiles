return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {
            check_ts = true,
            disable_filetype = { "telescopeprompt" },
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },

            fast_wrap = {
                map = "<m-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "pmenusel",
                highlight_grey = "linenr",
            },
        }
        -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done {})
    end,
}

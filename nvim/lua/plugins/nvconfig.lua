return {
    "NvChad/base46",
    event = "VimEnter",
    build = function()
        require("base46").load_all_highlights()
    end,
}

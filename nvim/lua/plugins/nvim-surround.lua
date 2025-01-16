-- A collection a small plugins that makes the editor more pleasant to use
local makeKey = require("utils.makeKey")

SetUndoKey = makeKey("Undo")

return {
    {
        "kylechui/nvim-surround",
        version = "*",
        keys = { "cs", "ds", "ys" },
        config = function()
            require("nvim-surround").setup({})
        end,
    },
}

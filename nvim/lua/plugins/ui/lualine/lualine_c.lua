-- TODO: here I just place the branch and the diff thing
-- diagnostics is going to lualine_x

local gitIcons = require("utils.signs.git")

return {
    -- TODO: custom that thing brother
    -- remove the separator too
    {
        "branch",
        icon = "",
    },
    {
        "diff",
        symbols = {
            added = gitIcons.added,
            modified = gitIcons.modified,
            removed = gitIcons.removed,
        },
        padding = { left = 1, right = 0 },
    },
}

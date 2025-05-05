local overrideDevicons = {
    default_icon = { icon = "󰈚", name = "Default" },
    js = { icon = "󰌞", name = "js" },
    ts = { icon = "󰛦", name = "ts" },
    lock = { icon = "󰌾", name = "lock" },
    ["robots.txt"] = { icon = "󰚩", name = "robots" },
}

return {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    opts = function()
        return { override = overrideDevicons }
    end,
}

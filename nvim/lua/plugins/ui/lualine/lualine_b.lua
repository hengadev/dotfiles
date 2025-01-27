return {
    {
        "filetype",
        icon_only = true,
        separator = "",
        padding = {
            left = 1,
            right = 0,
        },
    },
    {
        "filename",
        path = 4,
        shorting_target = 10, -- Shortens path to leave 10 spaces in the window
        symbols = {
            modified = "  ",
            readonly = "",
            unnamed = ""
        }
    },
}

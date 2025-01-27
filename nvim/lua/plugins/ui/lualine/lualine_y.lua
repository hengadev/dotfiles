return {
    {
        function()
            -- local icon = "%#St_cwd_icon#" .. "󰉋 "
            local name = vim.uv.cwd()
            -- name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
            name = "%#St_cwd_text#" .. (name:match "([^/\\]+)[/\\]*$" or name)
            -- return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. icon .. name)) or ""
            return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. name)) or ""
        end,
        padding = { left = 0, right = 1 },
        icon = {
            "󰉋 ",
            color = { bg = "#FF0000", fg = "#FFFFFF" },
        },
        -- color = { bg = "#FF0000", fg = "#FFFFFF" },
    },
    {
        "progress",
        icon = {
            "",
            color = { bg = "#0000FF", fg = "#FFFFFF" },
        },
        padding = { left = 1, right = 1 },
        color = { bg = "#0000FF", fg = "#FFFFFF" },
    },
}

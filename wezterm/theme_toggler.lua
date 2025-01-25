local M = {}

M.set = function(api, theme, theme_type)
    return function(window)
        local overrides = window:get_config_overrides() or {}
        api.log_info("Setting to " .. theme_type, overrides.color_scheme)
        overrides.color_scheme = theme
        window:set_config_overrides(overrides)
    end
end

-- Function to read theme from file
local read_theme_file = function()
    local theme_file = io.open(os.getenv("HOME") .. "/.theme_state", "r")
    if theme_file then
        local theme = theme_file:read("*all")
        theme_file:close()
        return theme:match("^%s*(.-)%s*$") -- trim whitespace
    end
    return "dark"                          -- default theme
end

M.watch_theme_file = function(api)
    return function(window)
        local theme_type = read_theme_file()
        if theme_type == "light" then
            M.theme_toggler.set(api, "flexoki-light", "light")(window)
        elseif theme_type == "dark" then
            M.theme_toggler.set(api, "Sweet Eliverlara (Gogh)", "dark")(window)
        end
    end
end

return M

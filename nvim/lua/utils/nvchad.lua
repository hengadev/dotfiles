-- NOTE: This function comes from : https://github.com/NvChad/ui/blob/474199ac96e898be73905c2009d74690a0a6738e/lua/nvchad/utils.lua

local M = {}

M.list_themes = function()
    local default_themes = vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes")
    -- NOTE: handle custom themes if I need to, but I do not think I will need it
    -- local custom_themes = vim.uv.fs_stat(fn.stdpath "config" .. "/lua/themes")
    --
    -- if custom_themes and custom_themes.type == "directory" then
    --     local themes_tb = fn.readdir(fn.stdpath "config" .. "/lua/themes")
    --     for _, value in ipairs(themes_tb) do
    --         table.insert(default_themes, value)
    --     end
    -- end

    for index, theme in ipairs(default_themes) do
        default_themes[index] = theme:match "(.+)%..+"
    end

    return default_themes
end

M.replace_word = function(old, new, filepath)
    filepath = filepath or vim.fn.stdpath "config" .. "/lua/" .. "nvconfig.lua"

    if not filepath then
        print("Error: filepath in NVChad theme picker extension is nil")
        return
    end
    local file = io.open(filepath, "r")
    if not file then
        print("Error: Could not open file for reading")
        return
    end
    if file then
        local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
        local new_content = file:read("*all"):gsub(added_pattern, new)

        file = io.open(filepath, "w")
        if not file then
            print("Error: Could not open file for writing for NVChad theme picker extension")
            return
        end
        file:write(new_content)
        file:close()
    end
end

---@param theme_name string
M.set_wezterm_theme = function(theme_name)
    local theme = require("base46.themes." .. theme_name)
    local type = theme.type

    if not type then
        print(string.format("Error: Theme '%s' does not define a 'type'.", theme_name))
        return
    end

    print("the type in the reload is :", type)

    -- if type == "light" then
    --     print("Changing wezterm color theme to light")
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-!>", true, true, true), "n", true)
    -- vim.cmd([[call feedkeys("\<C-!>")]])
    -- io.write('\027[27;5;49~') -- Try this escape sequence for Ctrl+1
    -- vim.fn.system('wezterm cli set-user-var nvim_theme light')
    -- vim.fn.system('/usr/bin/wezterm cli set-user-var nvim_theme light')
    -- vim.fn.system('/usr/bin/wezterm cli send-text --no-paste "\x01\x31"') -- Ctrl+1
    -- elseif type == "dark" then
    --     print("Changing wezterm color theme to dark")
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-@>", true, true, true), "n", true)
    -- vim.cmd([[call feedkeys("\<C-@>")]])
    -- io.write('\027[27;5;50~') -- Try this escape sequence for Ctrl+2
    -- vim.fn.system('wezterm cli set-user-var nvim_theme dark')
    -- vim.fn.system('/usr/bin/wezterm cli set-user-var nvim_theme dark')
    -- vim.fn.system('/usr/bin/wezterm cli send-text --no-paste "\x01\x32"') -- Ctrl+2
    -- else
    --     print(string.format("Error: theme '%s' is not supported. Use 'light' or 'dark'.", type))
    -- end

    if type == "light" or type == "dark" then
        -- Write the theme type to file
        local f = io.open(os.getenv("HOME") .. "/.theme_state", "w")
        if f then
            f:write(type)
            f:close()
            -- Trigger WezTerm config reload using a faster method
            -- TODO: check if that one is good because I am not sure
            -- vim.fn.system('kill -SIGUSR1 $(pgrep wezterm-gui)')
        else
            print("Error: Could not write to theme state file")
        end
    else
        print(string.format("Error: theme '%s' is not supported. Use 'light' or 'dark'.", type))
    end
end

return M

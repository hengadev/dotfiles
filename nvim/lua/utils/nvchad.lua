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

return M

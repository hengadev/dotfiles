local M = {}

M.replace_word = function(old, new, filepath)
    -- filepath = filepath or vim.fn.stdpath "config" .. "/lua/" .. "nvconfig.lua"
    -- TODO: I need to fix the file path to make it work
    local config = vim.fn.stdpath("config")
    local avante_filepath = vim.fs.joinpath(config, "lua", "plugins", "avante", "init.lua")
    print(avante_filepath)
    filepath = filepath or avante_filepath

    if not filepath then
        print("Error: filepath in Avante provider picker extension is nil")
        return
    end

    local file = io.open(filepath, "r")
    if not file then
        print("Error: Could not open file for reading")
        return
    end

    -- TODO: the only part that remains for that configuration
    if file then
        local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
        local new_content = file:read("*all"):gsub(added_pattern, new)

        file = io.open(filepath, "w")
        if not file then
            print("Error: Could not open file for writing for Avante provider picker extension")
            return
        end
        file:write(new_content)
        file:close()
    end
end

return M

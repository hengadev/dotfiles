local M = {}

M.replace_word = function(old, new, filepath)
    local avante_filepath = vim.fn.stdpath "config" .. "/lua/plugins/avante/init.lua"
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

return M

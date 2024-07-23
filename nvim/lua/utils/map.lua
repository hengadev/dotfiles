local M = {}

-- setting key maps for the plugin
---a helper function first to help with the settings of the keymaps.
---@params:key string
---@params:func func()
---@params:desc string
function M.set_prefix(prefix)
    return function(key, cmd, desc, modes)
        if modes == nil then
            vim.keymap.set("n", key, cmd, { desc = prefix .. ": " .. desc })
            return
        end
        for _, mode in pairs(modes) do
            vim.keymap.set(mode, key, cmd, { desc = prefix .. ": " .. desc })
        end
    end
end

return M

--- Setting prefix for the keymaps.
---@param prefix string
MakeKey = function (prefix)
--- Setting key maps for the plugin.
---@param key string
---@param func string|function
---@param mode string|table|nil
---@param silent boolean|nil
---@param expr boolean|nil
---@return table
    return function(key, func, desc, mode, silent, expr)
        local table = {
            key,
            func,
            desc = prefix .. ": " ..desc,
        }
        if mode ~= nil then
            table["mode"] = mode
        end
        if silent ~= nil then
            table["silent"] = silent
        end
        if expr ~= nil then
            table["expr"] = expr
        end
        return table
    end
end

return  MakeKey

-- [[ Useful Functions ]]
-- Some functions for plugin development in lua :
P = function(v)
    vim.print("\n")
    vim.print(v) -- to use instead of the pretty_print see on the internet - see document :h pretty_print
    -- NOTE: Old, the one use by teej in this video (https://www.youtube.com/watch?v=n4Lp4cV8YR0&t=614s)
    -- print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

vim.api.nvim_create_user_command("SaveAndExecuteLuaFile", function()
    vim.cmd("silent !w")
    vim.cmd("source %")
end, { desc = "Dev: Save and execute a lua file." })

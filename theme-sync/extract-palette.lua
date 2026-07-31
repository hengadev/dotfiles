-- Run headless, without loading the user's nvim config, to read a base46
-- theme's type + base_16 palette directly. Invoked by set-theme.sh with
-- THEME_NAME set in the environment.
local name = os.getenv("THEME_NAME")
if not name then
    io.stderr:write("extract-palette.lua: THEME_NAME not set\n")
    vim.cmd("cquit 1")
end

local ok, theme = pcall(require, "base46.themes." .. name)
if not ok then
    io.stderr:write("extract-palette.lua: no such theme '" .. name .. "'\n")
    vim.cmd("cquit 1")
end

io.write(vim.fn.json_encode({ type = theme.type, base16 = theme.base_16 }))
vim.cmd("qa")

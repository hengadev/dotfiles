vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("User", {
    desc = "Propagate the active base46 theme's light/dark type to waybar/tmux/herdr/wallpaper",
    pattern = "NvThemeReload",
    group = vim.api.nvim_create_augroup("theme-sync", { clear = true }),
    callback = function()
        local theme_name = require("nvconfig").base46.theme
        local ok, theme_mod = pcall(require, "base46.themes." .. theme_name)
        if not ok or (theme_mod.type ~= "light" and theme_mod.type ~= "dark") then
            return
        end

        local state_file = vim.fn.expand("~/.theme_state")
        vim.fn.writefile({ theme_mod.type }, state_file)

        vim.fn.jobstart({ vim.fn.expand("~/.config/theme-sync/apply-theme.sh") }, { detach = true })
    end,
})

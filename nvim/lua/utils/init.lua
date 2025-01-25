local M = {}

-- icon signs
local signs = require("utils.signs")
M.git = signs.git
M.lsp_kinds = signs.lsp_kinds
M.dap_utils = signs.dap

-- constants
M.mason_packages = require("utils.constants.mason")
M.lsp_servers = require("utils.constants.lsp_servers")

function M.warn(msg, notify_opts)
    vim.notify(msg, vim.log.levels.WARN, notify_opts)
end

function M.error(msg, notify_opts)
    vim.notify(msg, vim.log.levels.ERROR, notify_opts)
end

function M.info(msg, notify_opts)
    vim.notify(msg, vim.log.levels.INFO, notify_opts)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return require("utils").info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            require("utils").info("Enabled " .. option, { title = "Option" })
        else
            require("utils").warn("Disabled " .. option, { title = "Option" })
        end
    end
end

M.diagnostics_active = true
function M.toggle_diagnostics()
    M.diagnostics_active = not M.diagnostics_active
    if M.diagnostics_active then
        vim.diagnostic.show()
        require("utils").info("Enabled Diagnostics", { title = "Lsp" })
    else
        vim.diagnostic.hide()
        require("utils").warn("Disabled Diagnostics", { title = "Lsp" })
    end
end

M.quickfix_active = false
function M.toggle_quickfix()
    M.quickfix_active = not M.quickfix_active
    if M.quickfix_active then
        vim.diagnostic.setloclist()
    else
        vim.cmd([[ lclose ]])
    end
end

-- Pour configurer le plugin which-key, je recupere ce qui suit de son fichier utils
-- https://github.com/alpha2phi/modern-neovim/blob/main/lua/plugins/whichkey.lua
-- Je copie juste la partie du fichier qui m'interesse ie la fonction quitk

function M.quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_windows = vim.call("win_findbuf", bufnr)
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if modified and #buf_windows == 1 then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd "qa!"
            end
        end)
    else
        vim.cmd "qa!"
    end
end

-- Je copie ici deux trois fonctions de lazyVim qui me permette de configurer ui.lua

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

return M

-- Source:
-- https://github.com/NavePnow/dotfiles/blob/main/.config/nvim/lua/utils/init.lua

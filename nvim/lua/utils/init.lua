-- A part avant la fin, tous les elements de cette page vienent de : https://github.com/NavePnow/dotfiles/blob/main/.config/nvim/lua/utils/init.lua
local M = {}

M.git_colors = {
    GitAdd = "#A1C281",
    GitChange = "#74ADEA",
    GitDelete = "#FE747A",
}
M.lsp_signs = { Error = "✖ ", Warn = "! ", Hint = "󰌶 ", Info = " " }
-- Je rajoute cela pour la config de lualine dans ui.lua
M.git = { added = " ", modified = " ", removed = " " }

-- -- Les icones ici ne fonctionne pas, il faut retrouver chez qui j'ai pris cela et tout remplacer
-- On peut les retrouver sur le github de lsp kind
M.lsp_kinds = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ ",
    Variable = " ",
    Class = "ﴯ ",
    Interface = " ",
    Module = " ",
    Property = "ﰠ ",
    Unit = "塞",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = "  ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ ",
    Event = " ",
    Operator = " ",
    Copilot = " ",
    -- C'etait bien un probleme de font tout est regle des que j'utilise un nerd font comme FiraCode
    TypeParameter = " ",
    Namespace = " ",
    Package = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
}

-- Ici je  vais mettre toutes les icons pour mon debugger que je reucpere de lunarvim
-- Il y a plus d'icones que necessaire puisque c'est la liste utilisee pour toute la config
M.dap_utils = {
    dap_icons = {
        ArrowCircleDown = "",
        ArrowCircleLeft = "",
        ArrowCircleRight = "",
        ArrowCircleUp = "",
        BoldArrowDown = "",
        BoldArrowLeft = "",
        BoldArrowRight = "",
        BoldArrowUp = "",
        BoldClose = "",
        BoldDividerLeft = "",
        BoldDividerRight = "",
        BoldLineLeft = "▎",
        BookMark = "",
        BoxChecked = "",
        Bug = "",
        Stacks = "",
        Scopes = "",
        Watches = "󰂥",
        DebugConsole = "",
        Calendar = "",
        Check = "",
        ChevronRight = ">",
        ChevronShortDown = "",
        ChevronShortLeft = "",
        ChevronShortRight = "",
        ChevronShortUp = "",
        Circle = "",
        Close = "󰅖",
        CloudDownload = "",
        Code = "",
        Comment = "",
        Dashboard = "",
        DividerLeft = "",
        DividerRight = "",
        DoubleChevronRight = "»",
        Ellipsis = "",
        EmptyFolder = "",
        EmptyFolderOpen = "",
        File = "",
        FileSymlink = "",
        Files = "",
        FindFile = "󰈞",
        FindText = "󰊄",
        Fire = "",
        Folder = "󰉋",
        FolderOpen = "",
        FolderSymlink = "",
        Forward = "",
        Gear = "",
        History = "",
        Lightbulb = "",
        LineLeft = "▏",
        LineMiddle = "│",
        List = "",
        Lock = "",
        NewFile = "",
        Note = "",
        Package = "",
        Pencil = "󰏫",
        Plus = "",
        Project = "",
        Search = "",
        SignIn = "",
        SignOut = "",
        Tab = "󰌒",
        Table = "",
        Target = "󰀘",
        Telescope = "",
        Text = "",
        Tree = "",
        Triangle = "󰐊",
        TriangleShortArrowDown = "",
        TriangleShortArrowLeft = "",
        TriangleShortArrowRight = "",
        TriangleShortArrowUp = "",
    },
    dap_builtin = {
        active = true,
        on_config_done = nil,
        breakpoint = {
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
        },
        breakpoint_rejected = {
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = "",
            texthl = "DiagnosticSignWarn",
            linehl = "Visual",
            numhl = "DiagnosticSignWarn",
        },
        log = {
            level = "info",
        },
    }
}



M.mason_packages = {
    "bash-language-server",
    "black",
    "clang-format",
    "clangd",
    "codelldb",
    "cspell",
    "css-lsp",
    "eslint-lsp",
    "graphql-language-service-cli",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "markdownlint",
    "prettier",
    "pyright",
    "shfmt",
    "stylua",
    "tailwindcss-language-server",
    "taplo",
    "typescript-language-server",
    "yaml-language-server",
    "gopls",
    "editorconfig-checker"
}

M.lsp_servers = {
    "clangd",
    "tsserver",
    "pyright",
    "lua_ls",
    "eslint",
    "bashls",
    "yamlls",
    "jsonls",
    "cssls",
    "taplo",
    "html",
    "graphql",
    "tailwindcss",
    "gopls",
}

function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

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


-- setting key maps for the plugin
---a helper function first to help with the settings of the keymaps.
---@params:key string
---@params:func func()
---@params:desc string
function M.map(prefix)
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

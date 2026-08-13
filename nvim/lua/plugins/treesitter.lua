-- plugins
vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- config
require("nvim-treesitter").install({
    "lua",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "bash",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "svelte",
    "rust",
    "c",
    "cpp",
    "go",
    "python",
    "json",
    "yaml",
})

local available_parsers = nil
local function has_parser(lang)
    if not available_parsers then
        local ok, list = pcall(function()
            return require("nvim-treesitter.config").get_available()
        end)
        available_parsers = ok and list or {}
    end
    return vim.tbl_contains(available_parsers, lang)
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not has_parser(lang) then
            return
        end

        if not vim.treesitter.language.add(lang) then
            local ok = pcall(function()
                require("nvim-treesitter").install(lang):wait(30000)
            end)
            if not ok or not vim.treesitter.language.add(lang) then
                return
            end
        end

        vim.treesitter.start()
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

local options = {
    nu = true,
    relativenumber = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    wrap = false,
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    hlsearch = false,
    incsearch = true,
    showmode = false,
    termguicolors = true,
    scrolloff = 8,
    signcolumn = "yes",
    updatetime = 50,
    colorcolumn = "80",
    -- case independant searching
    ignorecase = true,
    smartcase = true,
    -- sync clipboard between os and nvim
    clipboard = 'unnamedplus',
    conceallevel = 1,
}

-- NOTE: for obsidian
vim.o.conceallevel = 2

vim.opt.isfname:append("@-@")

for key, value in pairs(options) do
    vim.opt[key] = value
end

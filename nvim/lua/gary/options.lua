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
    updatetime = 250,
    colorcolumn = "100",
    -- Decrease mapped sequence wait time
    -- Displays which-key popup sooner
    timeoutlen = 300,
    -- Configure how new splits should be opened
    splitright = true,
    splitbelow = false,
    -- case independant searching
    ignorecase = true,
    smartcase = true,
    -- Sets how neovim will display certain whitespace characters in the editor.
    --  See `:help 'list'`
    --  and `:help 'listchars'`
    list = true,
    listchars = { tab = "» ", trail = "·", nbsp = "␣" },
    -- Preview substitutions live, as you type!
    inccommand = "split",

    -- Show which line your cursor is on
    cursorline = true,
    cursorcolumn = false, -- do not know if I keep that one.
    -- sync clipboard between os and nvim
    clipboard = "unnamedplus",
    conceallevel = 1,
}

-- NOTE: for obsidian
vim.o.conceallevel = 2

vim.opt.isfname:append("@-@")

for key, value in pairs(options) do
    vim.opt[key] = value
end

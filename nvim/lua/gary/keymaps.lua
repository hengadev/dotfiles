vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Return to netrw" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Replace the Esc key to return in normal mode" })

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- To move things around when highlighted.
vim.keymap.set(
	"v",
	"J",
	":m '>+1<CR>gv=gv",
	{ desc = "Move the selected line upwards or exchange with the line above if there is content" }
)
vim.keymap.set(
	"v",
	"K",
	":m '<-2<CR>gv=gv",
	{ desc = "Move the selected line downwards, or  excchange with the line below if there is content" }
)

vim.keymap.set("n", "J", "mzJ`z")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- TODO: make the two next work
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keep the cursor in the middle vertically when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- To navigate while having the cursor centered vertically
vim.keymap.set("n", "}", "}zzzv")
vim.keymap.set("n", "{", "{zzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allows to select + copy and keep the copy inside the _ register.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Keep the last deleted selection into the _ register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- A utiliser pour parcourir les elements de la quickfixlist beaucoup plus facilement.
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Move down in the quickfixlist" })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Move down in the quickfixlist" })

-- Pour remplacer toutes les occurrence du mot sur lequel je suis, mais je peux faire cela facilement avec un regex.
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace all the occurrences of the word under the cursor in the current buffer" }
)
vim.keymap.set(
	"n",
	"<leader>x",
	"<cmd>!chmod +x %<CR>",
	{ silent = true, desc = "Change the current buffered file to be executable" }
)

-- NOTE: For plugin development
vim.keymap.set("n", "<leader>ex", "<Cmd>SaveAndExecuteLuaFile<CR>", { silent = true, desc = "[EX]ecute lua file" })

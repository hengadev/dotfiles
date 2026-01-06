vim.g.mapleader = " "
vim.g.have_nerd_font = true

local map = require("utils.helpers").set_prefix("Custom")

-- the best remap ever !
map("jk", "<Esc>", "Replace the Esc key to return in normal mode", { "i" })

-- tab handling
map("<leader>nt", "<Cmd>tabnew<CR>", "[N]ew [T]ab")
map("<leader>ct", "<Cmd>tabclose<CR>", "[C]lose current [T]ab")

-- Help to work with lazy and mason menus
map("<leader>lz", "<Cmd>Lazy<CR>", "Open [L]a[Z]y menu")
map("<leader>ms", "<Cmd>Mason<CR>", "Open [M]a[S]on menu")
map("<leader>mu", "<Cmd>MasonToolsUpdate<CR>", "Open [M]ason [U]pdate")

-- old, do not use since oil.nvim
-- map("<leader>pv", vim.cmd.Ex, "Return to netrw")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map("<Esc>", "<cmd>nohlsearch<CR>", "Clear hightlight on pressing <Esc>")

-- Diagnostic keymaps
map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic message")
map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")

-- To move lines up and down when highlighted.
map(
	"J",
	":m '>+1<CR>gv=gv",
	"Move the selected lines upwards or exchange with the line above if there is content",
	{ "v" }
)
map(
	"K",
	":m '<-2<CR>gv=gv",
	"Move the selected lines downwards, or  excchange with the line below if there is content",
	{ "v" }
)

map("J", "mzJ`z", "Append the line below your current separated by a space")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("<C-l>", "<C-w><C-l>", "Move focus to the right window")

-- TODO: make the two next work
map("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- Keep the cursor in the middle vertically when searching
map("n", "nzzzv", "Search to next occurences with cursor centered vertically")
map("N", "Nzzzv", "Search to previous occurences with cursor centered vertically")

-- To navigate while having the cursor centered vertically
map("}", "}zzzv", "Navigate a paragraph downward with cursor centered vertically")
map("{", "{zzzv", "Navigate a paragraph upward with cursor centered vertically")
map("<C-d>", "<C-d>zz", "Navigate a paragraph half the screen down with cursor centered vertically")
map("<C-u>", "<C-u>zz", "Navigate a paragraph half the screen up with cursor centered vertically")

-- Allows to select + copy and keep the copy inside the _ register.
-- map("<leader>p", [["_dP]], "Select and copy inside the _ register")
map("<leader>p", [["_dP]], "Select and copy inside the _ register", { "v" })

-- next greatest remap ever : asbjornHaland
-- TODO: right the description for these files
map("<leader>y", [["+y]], "", { "n", "v" })
map("<leader>Y", [["+Y]], "")

-- Keep the last deleted selection into the _ register
map("<leader>d", [["_d]], "Keep  the last deleted selection inside the _ register", { "n", "v" })

-- A utiliser pour parcourir les elements de la quickfixlist beaucoup plus facilement.
map("<C-k>", "<cmd>cprev<CR>zz", "Move down in the quickfixlist")
map("<C-j>", "<cmd>cnext<CR>zz", "Move down in the quickfixlist")

-- Pour remplacer toutes les occurrence du mot sur lequel je suis, mais je peux faire cela facilement avec un regex.
map(
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	"Replace all the occurrences of the word under the cursor in the current buffer"
)
map("<leader>x", "<cmd>!chmod +x %<CR>", "Change the current buffered file to be executable")

-- NOTE: For plugin development
map("<leader>cx", "<Cmd>SaveAndExecuteLuaFile<CR>", "E[X]ecute lua file")

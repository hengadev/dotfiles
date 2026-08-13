-- Keymaps

vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- Best remap EVER !!!
vim.keymap.set('i', "jk", "<Esc>", { desc = "Replace the Esc key to return in normal mode"})

vim.keymap.set('n', "<leader>pv", vim.cmd.Ex, {desc="Return to netrw"})

-- tab handling
vim.keymap.set('n', "<leader>nt", "<Cmd>tabnew<CR>", {desc = "[N]ew [T]ab"})
vim.keymap.set('n', "<leader>ct", "<Cmd>tabclose<CR>", {desc = "[C]lose current [T]ab"})


-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc="Clear hightlight on pressing <Esc>"})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, {desc="Go to previous [D]iagnostic message"})
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, {desc="Go to next [D]iagnostic message"})

-- To move lines up and down when highlighted.
vim.keymap.set( "v", "J", ":m '>+1<CR>gv=gv", { desc="Move the selected lines upwards or exchange with the line above if there is content" })
vim.keymap.set( "v", "K", ":m '<-2<CR>gv=gv", { desc="Move the selected lines downwards, or  excchange with the line below if there is content" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc="Move focus to the left window"})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc="Move focus to the right window"})

-- Keep the cursor in the middle vertically when searching
vim.keymap.set("n", "n", "nzzzv", {desc="Search to next occurences with cursor centered vertically"})
vim.keymap.set("n", "N", "Nzzzv", {desc="Search to previous occurences with cursor centered vertically"})

-- To navigate while having the cursor centered vertically
vim.keymap.set("n","}", "}zzzv", {desc="Navigate a paragraph downward with cursor centered vertically"})
vim.keymap.set("n","{", "{zzzv", {desc="Navigate a paragraph upward with cursor centered vertically"})
vim.keymap.set("n","<C-d>", "<C-d>zz", {desc="Navigate a paragraph half the screen down with cursor centered vertically"})
vim.keymap.set("n","<C-u>", "<C-u>zz", {desc="Navigate a paragraph half the screen up with cursor centered vertically"})

-- Allows to select + copy and keep the copy inside the _ register.
vim.keymap.set("v", "<leader>p", [["_dP]], {desc="Select and copy inside the _ register"})

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"},"<leader>y", [["+y]], {desc=""})
vim.keymap.set("n","<leader>Y", [["+Y]], {desc=""})

-- Keep the last deleted selection into the _ register
vim.keymap.set({ "n", "v" },"<leader>d", [["_d]], {desc="Keep  the last deleted selection inside the _ register"})

-- A utiliser pour parcourir les elements de la quickfixlist beaucoup plus facilement.
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", {desc="Move down in the quickfixlist"})
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", {desc="Move down in the quickfixlist"})

-- Pour remplacer toutes les occurrence du mot sur lequel je suis, mais je peux faire cela facilement avec un regex.
vim.keymap.set(
    "n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    {desc="Replace all the occurrences of the word under the cursor in the current buffer"}
)

vim.keymap.set("n","<leader>x", "<cmd>!chmod +x %<CR>", {desc="Change the current buffered file to be executable"})

vim.keymap.set("n", "<leader>cx", "<Cmd>SaveAndExecuteLuaFile<CR>", {desc="E[X]ecute lua file"})



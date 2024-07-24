-- TODO: Can I use the LSP to find the correct way to run commands and try to use that to make the different command automatically ? Can I make this a plugin ?
-- That plugin could actually make makefiles if the user wanted to ?

local build_commands = {
	c = "gcc -o %:p:r.o %",
	cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
	rust = "cargo build --release",
	go = "go build -o %:p:r.o %",
	typescript = "tsc %:p:r.ts",
}

local debug_build_commands = {
	c = "gcc -g -o %:p:r.o %",
	cpp = "g++ -std=c++17 -g -o %:p:r.o %",
	rust = "cargo build",
	go = "go build -o %:p:r.o %",
	typescript = "tsc %:p:r.ts",
}

local run_commands = {
	c = "%:p:r.o",
	cpp = "%:p:r.o",
	rust = "cargo run --release",
	go = "%:p:r.o",
	typescript = "node %:p:r.js",
	javascript = "node %:p:r.js",
	python = "python3 %:p:r.py",
	java = "java %:p:r.java",
}

-- TODO: Make a run release command for rust specifically because I want to have run and run_release, the same way with debug and debug_release ?

local function bind(op, outer_opts)
	outer_opts = outer_opts or { noremap = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

local nnoremap = bind("n")
-- NOTE: Not used in this file
-- local nmap = bind("n", { noremap = false })
-- local vnoremap = bind("v")
-- local xnoremap = bind("x")
-- local inoremap = bind("i")
-- local tnoremap = bind("t")

local t = {
	Build = { name = build_commands, keymap = "cb", desc = "Build Release" },
	DebugBuild = { name = debug_build_commands, keymap = "cd", desc = "Build Debug" },
	Run = { name = run_commands, keymap = "cl", desc = "Run" },
}

-- Make a general function to create the custom command
local create_custom_command = function(command_name, command_table)
	vim.api.nvim_create_user_command(command_name, function()
		local filetype = vim.bo.filetype

		for file, command in pairs(command_table) do
			if filetype == file then
				if command_name == "Run" then
					vim.cmd("sp")
					vim.cmd("term " .. command)
					vim.cmd("resize 10S")
					local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
					vim.api.nvim_feedkeys(keys, "n", false)
				else
					vim.cmd("!" .. command)
				end
				break
			end
		end
	end, {})
end

-- Building the functions.
for name, command_table in pairs(t) do
	nnoremap(
		"<leader>" .. command_table["keymap"],
		"<Cmd>" .. name .. "<CR>",
		{ silent = true, desc = "Custom : " .. command_table["desc"] }
	)
	create_custom_command(name, command_table["name"])
end

-- For rust, a combination of bulding and running release
vim.api.nvim_create_user_command("Ha", function()
	vim.cmd([[Build]])
	vim.cmd([[Run]])
end, {})
nnoremap("<leader>cr", "<Cmd>Ha<CR>", { silent = true, desc = "Build and Run" })

-- NOTE: from the dotfiles in https://github.com/NycRat/dotfiles

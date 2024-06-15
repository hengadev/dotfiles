-- TODO: Please finish the debugging thing
local write_desc = function(desc)
	return "DAP: " .. desc
end

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	event = "InsertEnter",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		vim.keymap.set("n", "<leader>dR", dap.run_to_cursor, { desc = write_desc("[D]ebug [R]un toCursor") })
		vim.keymap.set("n", "<leader>dE", function()
			dapui.eval(vim.fn.input("[Expression] > "))
		end, { desc = write_desc("[D]ebug[E]valuate Input") })
		vim.keymap.set("n", "<leader>dC", function()
			dap.set_breakpoint(vim.fn.input("[Condition] > "))
		end, { desc = write_desc("[D]ebug [C]onditional Breakpoint") })
		vim.keymap.set("n", "<leader>dU", function()
			require("dapui").toggle()
		end, { desc = write_desc("[D]ebug Toggle [U]I") })
		vim.keymap.set("n", "<leader>db", dap.step_back, { desc = write_desc("[D]ebug Step [B]ack") })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = write_desc("[D]ebug [C]ontinue") })
		vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = write_desc("[D]ebug [D]isconnect") })
		vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = write_desc("[D]ebug [E]valuate") })
		vim.keymap.set("n", "<leader>dg", dap.session, { desc = "[D]ebug Get Session" })
		vim.keymap.set("n", "<leader>dh", function()
			dap.ui.widgets.hover()
		end, { desc = write_desc("[D]ebug: [H]over Variables") })
		vim.keymap.set("n", "<leader>dS", function()
			dap.ui.widgets.scopes()
		end, { desc = write_desc("[D]ebug [S]copes") })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = write_desc("[D]ebug Step [I]nto") })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = write_desc("[D]ebug Step [O]ver") })
		vim.keymap.set("n", "<leader>dp", dap.pause, { desc = write_desc("[D]ebug [P]ause") })
		vim.keymap.set("n", "<leader>dq", dap.close, { desc = write_desc("[D]ebug [Q]uit") })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = write_desc("[D]ebug Toggle [R]EPL") })
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = write_desc("[D]ebug [S]tart debugger") })
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = write_desc("[D]ebug [T]oggle Breakpoint") })
		vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = write_desc("[D]ebug Terminate debug session") })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = write_desc("[D]ebug Step Out") })
		vim.keymap.set("n", "<leader>dU", function()
			require("dapui").toggle()
		end, { desc = write_desc("[D]ebug Toggle [U]I") })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			-- NOTE: default version
			-- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			icons = { expanded = "", collapsed = "", circular = "" },
			controls = {
				icons = {
					pause = "",
					play = "",
					step_into = "",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "",
					terminate = "",
				},
			},
			-- Positionning of elements :
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			-- Use this to override mappings for specific elements
			element_mappings = {},
			expand_lines = true,
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.33 },
						{ id = "breakpoints", size = 0.17 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 0.33,
					position = "right",
				},
				{
					elements = {
						{ id = "repl", size = 0.45 },
						{ id = "console", size = 0.55 },
						-- J'avais enleve la console sauf qu'il s'en trouve que j'en ai besoin en realite.
						-- { id = "repl", size = 1 },
					},
					size = 0.30,
					position = "bottom",
				},
				floating = {
					max_height = 0.9,
					max_width = 0.5, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			},
			-- opts = vim.tbl_extend("keep", opts or {}, {
			-- opts = vim.tbl_extend("keep", {
			opts = {
				title = "dap-ui",
				icon = "",
				on_open = function(win)
					local name = string.format("%d", vim.api.nvim_win_get_buf(win))
					vim.api.nvim_set_option_value(name, "filetype", { "markdown", "rust" })
				end,
				-- }),
			},
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup()
	end,
}

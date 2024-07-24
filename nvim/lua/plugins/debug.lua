local dap_cmd = "DapNew"

return {
	"mfussenegger/nvim-dap",
	-- event = "InsertEnter",
	cmd = dap_cmd,
	dependencies = {
		{"rcarriga/nvim-dap-ui", cmd=dap_cmd},
		-- Required dependency for nvim-dap-ui
		{"nvim-neotest/nvim-nio", cmd=dap_cmd},
		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		{"jay-babu/mason-nvim-dap.nvim", cmd=dap_cmd},
		-- Add your own debuggers here
		{"leoluz/nvim-dap-go", cmd=dap_cmd},
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

        local map = require("utils.map").set_prefix("Debug")
		map("<leader>dR", dap.run_to_cursor, "[D]ebug [R]un toCursor")
		map("<leader>dE", function() dapui.eval(vim.fn.input("[Expression] > ")) end, "[D]ebug[E]valuate Input")
		map("<leader>dC", function() dap.set_breakpoint(vim.fn.input("[Condition] > ")) end, "[D]ebug [C]onditional Breakpoint")
		map("<leader>db", dap.step_back, "[D]ebug Step [B]ack")
		map("<leader>dc", dap.continue, "[D]ebug [C]ontinue")
		map("<leader>dd", dap.disconnect, "[D]ebug [D]isconnect")
		map("<leader>de", dapui.eval, "[D]ebug [E]valuate", { "n", "v" })
		map("<leader>dg", dap.session, "[D]ebug Get Session")
		-- map("<leader>dh", function() dap.ui.widgets.hover() end, "[D]ebug: [H]over Variables")
		-- map("<leader>dS", function() dap.ui.widgets.scopes() end, "[D]ebug [S]copes")
		map("<leader>dh", require("dap.ui.widgets").hover, "[D]ebug: [H]over Variables")
		map("<leader>dS", function() require("dap.ui.widgets").scopes() end, "[D]ebug [S]copes")
		map("<leader>di", dap.step_into, "[D]ebug Step [I]nto")
		map("<leader>do", dap.step_over, "[D]ebug Step [O]ver")
		map("<leader>dp", dap.pause, "[D]ebug [P]ause")
		map("<leader>dq", dap.close, "[D]ebug [Q]uit")
		map("<leader>dr", require("dap.repl").toggle, "[D]ebug Toggle [R]EPL")
		map("<leader>ds", dap.continue, "[D]ebug [S]tart debugger")
		map("<leader>dt", dap.toggle_breakpoint, "[D]ebug [T]oggle Breakpoint")
		map("<leader>dx", dap.terminate, "[D]ebug Terminate debug session")
		map("<leader>du", dap.step_out, "[D]ebug Step Out")
		map("<leader>dU", dapui.toggle, "[D]ebug Toggle [U]I")

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
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
		map("<F7>", dapui.toggle, "Debug: See last session result.")

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup()
	end,
}

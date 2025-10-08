return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	config = function()
		-- Load the plugin with default config
		require("claudecode").setup()

		-- Load GLM module
		local glm = require("plugins.claudecode.glm")

		-- Create custom ClaudeCodeGLM command
		vim.api.nvim_create_user_command("ClaudeCodeGLM", function(opts)
			-- Handle visual mode exit (same as original ClaudeCode command)
			local current_mode = vim.fn.mode()
			if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
			end

			-- Get and validate GLM environment variables
			local glm_vars = glm.get_glm_env_vars()
			if not glm_vars then
				return
			end

			-- Set Claude Code environment variables
			glm.set_claude_env_vars(glm_vars)

			-- Launch Claude Code terminal
			local terminal = require("claudecode.terminal")
			local cmd_args = opts.args and opts.args ~= "" and opts.args or nil
			terminal.simple_toggle({}, cmd_args)
		end, {
			nargs = "*",
			desc = "Toggle Claude Code terminal with GLM models",
		})
	end,
	keys = {
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
		},
		-- Diff management
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		-- Custom GLM command
		{ "<leader>ag", "<cmd>ClaudeCodeGLM<cr>", desc = "Run Claude Code with GLM-4.6" },
	},
}

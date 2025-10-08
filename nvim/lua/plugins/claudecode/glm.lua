-- GLM environment variable management for ClaudeCode

local M = {}

-- Define required and optional environment variables
local ENV_VARS = {
	required = {
		api_key = "ZAI_API_KEY",
		base_url = "ZAI_BASE_URL",
	},
	optional = {
		opus_model = "GLM_OPUS_MODEL",
		sonnet_model = "GLM_SONNET_MODEL",
		haiku_model = "GLM_HAIKU_MODEL",
	},
}

-- Helper function to validate and get environment variables
function M.get_glm_env_vars()
	local env_vars = {}

	-- Get required variables
	for key, env_name in pairs(ENV_VARS.required) do
		env_vars[key] = os.getenv(env_name)
		if not env_vars[key] then
			vim.notify(env_name .. " environment variable not found", vim.log.levels.ERROR)
			return nil
		end
	end

	-- Get optional variables
	for key, env_name in pairs(ENV_VARS.optional) do
		env_vars[key] = os.getenv(env_name)
	end

	return env_vars
end

-- Helper function to set Claude Code environment variables
function M.set_claude_env_vars(glm_vars)
	vim.fn.setenv("ANTHROPIC_AUTH_TOKEN", glm_vars.api_key)
	vim.fn.setenv("ANTHROPIC_BASE_URL", glm_vars.base_url)
	vim.fn.setenv("ANTHROPIC_DEFAULT_OPUS_MODEL", glm_vars.opus_model)
	vim.fn.setenv("ANTHROPIC_DEFAULT_SONNET_MODEL", glm_vars.sonnet_model)
	vim.fn.setenv("ANTHROPIC_DEFAULT_HAIKU_MODEL", glm_vars.haiku_model)
	vim.fn.setenv("API_TIMEOUT_MS", "3000000")
end

return M

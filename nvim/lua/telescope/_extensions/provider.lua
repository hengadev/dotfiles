local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
-- local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
-- local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"

local list_providers = function()
    local avante_path = vim.fn.joinpath(vim.fn.stdpath "config", "lua", "avante", "providers")
    -- TODO: get all the lua files in this except init.lua
end

local utils = require("utils.avante")

local switcher = function()
    local picker = pickers.new({}, {
        prompt_title = " Set Avante Provider",
        previewer = false,           -- no previewer for this one, I just need to list the files in directory
        finder = finders.new_table { -- TODO: for now, I am just going to hard code that thing
            -- results = list_providers()
            results = {
                "mistral",
                "ollama",
                "claude",
            },
        },
        sorter = conf.generic_sorter(),

        attach_mappings = function(prompt_bufnr)
            ------------ save provider options to avante/init.lua on enter ----------------
            actions.select_default:replace(function()
                local old_provider = require("plugins.avante").opts.provider
                old_provider = '"' .. old_provider .. '"'

                local provider = '"' .. action_state.get_selected_entry()[1] .. '"'

                -- TODO: finish that function brother
                utils.replace_word(old_provider, provider)
                actions.close(prompt_bufnr)
            end)
            return true
        end,
    })

    picker:find()
end

-- TODO:
-- get a list of all providers in the 'right' directory
-- on select change the opts field in the avante file and reload the plugin ('avante')
--
-- TODO: use that to get all the providers that I have set

return require("telescope").register_extension {
    exports = { provider_picker = switcher },
}

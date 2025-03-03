local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
-- local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
-- local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"

local list_providers = function()
    local providers = vim.fn.readdir(vim.fn.stdpath "config" .. "/lua/plugins/avante/providers")
    for index, theme in ipairs(providers) do
        providers[index] = theme:match "(.+)%..+"
    end
    return providers
end

local utils = require("utils.avante")

local switcher = function()
    local picker = pickers.new({}, {
        prompt_title = " Set Avante Provider",
        previewer = false,
        finder = finders.new_table {
            results = list_providers()
        },
        -- winblend=10,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.4,
            height = 0.4,
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
        sorter = conf.generic_sorter(),
        attach_mappings = function(prompt_bufnr)
            ------------ save provider options to avante/init.lua on enter ----------------
            actions.select_default:replace(function()
                local old_provider = require("plugins.avante").opts.provider
                -- old_provider = '"' .. old_provider .. '"'
                print("the old provider:", old_provider)
                -- local provider = '"' .. action_state.get_selected_entry()[1] .. '"'
                local provider = action_state.get_selected_entry()[1]
                print("the new provider:", provider)

                utils.replace_word(old_provider, provider)
                actions.close(prompt_bufnr)
            end)
            return true
        end,
    })

    picker:find()
end

return require("telescope").register_extension {
    exports = { provider_picker = switcher }, }

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")

local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

local utils = require("utils.nvchad")
-- local utils = require("utils.base46")
--
-- utils.set_wezterm_theme("flexoki-light")
-- utils.set_wezterm_theme("ashes")

local function reload_theme(name)
    require("nvconfig").base46.theme = name
    require("base46").load_all_highlights()
    utils.set_wezterm_theme(name)
end

local function switcher()
    local bufnr = vim.api.nvim_get_current_buf()

    -- show current buffer content in previewer
    local previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry)
            -- add content
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

            -- add syntax highlighting in previewer
            local ft = (vim.filetype.match { buf = bufnr } or "diff"):match "%w+"
            require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)
        end,
    }

    -- our picker function: colors
    local picker = pickers.new({}, {
        prompt_title = "󱥚 Base46 Themes",
        previewer = previewer,
        -- TODO: make sur that I can get all the themes from this function
        finder = finders.new_table {
            results = utils.list_themes(),
        },
        sorter = conf.generic_sorter(),

        attach_mappings = function(prompt_bufnr)
            -- reload theme while typing
            vim.schedule(function()
                vim.api.nvim_create_autocmd("TextChangedI", {
                    buffer = prompt_bufnr,
                    callback = function()
                        if action_state.get_selected_entry() then
                            reload_theme(action_state.get_selected_entry()[1])
                        end
                    end,
                })
            end)
            -- reload theme on cycling
            actions.move_selection_previous:replace(function()
                action_set.shift_selection(prompt_bufnr, -1)
                reload_theme(action_state.get_selected_entry()[1])
            end)
            actions.move_selection_next:replace(function()
                action_set.shift_selection(prompt_bufnr, 1)
                reload_theme(action_state.get_selected_entry()[1])
            end)

            ------------ save theme to chadrc on enter ----------------
            actions.select_default:replace(function()
                if action_state.get_selected_entry() then
                    package.loaded.chadrc = nil
                    local old_theme = require("nvconfig").base46.theme
                    -- NOTE: before me trying to do the things the way I want to
                    old_theme = '"' .. old_theme .. '"'

                    local theme = '"' .. action_state.get_selected_entry()[1] .. '"'
                    -- local theme = action_state.get_selected_entry()[1]

                    utils.replace_word(old_theme, theme)
                    actions.close(prompt_bufnr)
                end
            end)
            return true
        end,
    })

    picker:find()
end

return require("telescope").register_extension {
    exports = { themes_picker = switcher },
}

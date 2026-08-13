local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")

local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

-- ported from old.nvim's lua/utils/nvchad.lua (originally from
-- https://github.com/NvChad/ui/blob/474199ac96e898be73905c2009d74690a0a6738e/lua/nvchad/utils.lua)
local function list_themes()
    local themes = vim.fn.readdir(vim.fn.stdpath("data") .. "/site/pack/core/opt/base46/lua/base46/themes")

    for index, theme in ipairs(themes) do
        themes[index] = theme:match("(.+)%..+")
    end

    return themes
end

local function replace_word(old, new, filepath)
    filepath = filepath or vim.fn.stdpath("config") .. "/lua/nvconfig.lua"

    local file = io.open(filepath, "r")
    if not file then
        vim.notify("Error: could not open " .. filepath .. " for reading", vim.log.levels.ERROR)
        return
    end

    local added_pattern = string.gsub(old, "-", "%%-") -- escape "-" if present
    local new_content = file:read("*all"):gsub(added_pattern, new)
    file:close()

    file = io.open(filepath, "w")
    if not file then
        vim.notify("Error: could not open " .. filepath .. " for writing", vim.log.levels.ERROR)
        return
    end
    file:write(new_content)
    file:close()
end

local function reload_theme(name)
    require("nvconfig").base46.theme = name
    require("base46").load_all_highlights()
end

local function switcher()
    local bufnr = vim.api.nvim_get_current_buf()
    -- store the initial theme at the start
    local initial_theme = require("nvconfig").base46.theme

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
            results = list_themes(),
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
                    local selected_name = action_state.get_selected_entry()[1]

                    local old_theme = '"' .. initial_theme .. '"'
                    local theme = '"' .. selected_name .. '"'
                    replace_word(old_theme, theme)
                    actions.close(prompt_bufnr)

                    -- Confirmed selection only (not live preview while cycling):
                    -- propagate the exact palette to tmux/wezterm/herdr/waybar/wallpaper.
                    vim.fn.jobstart(
                        { vim.fn.expand("~/.config/theme-sync/set-theme.sh"), selected_name },
                        { detach = true }
                    )
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


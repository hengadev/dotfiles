-- NOTE: here I do the remapping for nvchad theme switcher, that is custom from the nvchad thing

local map = require("utils.map").set_prefix("NVChad")
map("<leader>th", function()
    -- require("nvchad.themes").open()
    local builtin = require("telescope.builtin")
    local themes = require("nvconfig").base46.theme_toggle
    _ = themes
    builtin.open()
    -- builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, "Open NVChad base46 themes")

return {
	"NvChad/base46",
    event="VimEnter",
	build = function()
		require("base46").load_all_highlights()
	end,
}



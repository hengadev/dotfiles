-- plugins
vim.pack.add({
	"https://github.com/dmtrKovalenko/fff",
})

-- config
require("fff").setup({
	prompt = "> ",
	layout = {
		-- Pin the preview to the side. `preview_position` alone isn't
		-- enough: fff's flex-wrap logic runs after it and silently
		-- overrides it back to a stacked top/bottom layout on any terminal
		-- narrower than `flex.size` (130 columns by default) - which is
		-- most terminal windows/splits. `flex = false` turns that fallback
		-- off entirely so preview_position always wins.
		preview_position = "right",
		flex = false,
	},
})

-- fff ships a prebuilt Rust matcher, downloaded here (falls back to `cargo
-- build --release` if no prebuilt matches this platform). vim.pack has no
-- lazy.nvim-style `build` hook, so this has to be triggered explicitly.
-- `download_or_build_binary()` always forces a fresh download - fine for a
-- one-shot build hook, but not for something called on every startup - so
-- this uses `ensure_downloaded()` instead, which checks the binary is
-- already on disk first and is a no-op after the first install.
local fff_download = require("fff.download")
fff_download.ensure_downloaded({}, function(ok, err)
	if ok then
		return
	end
	vim.schedule(function()
		vim.notify(
			"fff.nvim: binary download failed (" .. tostring(err) .. "), falling back to cargo build",
			vim.log.levels.WARN
		)
	end)
	fff_download.build_binary(function(build_ok, build_err)
		if not build_ok then
			vim.schedule(function()
				vim.notify("fff.nvim: failed to build binary: " .. tostring(build_err), vim.log.levels.ERROR)
			end)
		end
	end)
end)

-- keymaps
-- Only find_files/live_grep move here from telescope.lua: fff is a fast,
-- frecency-ranked file finder + grep, not a picker framework - it has no
-- LSP/git/marks pickers, no ui-select, no theme picker, so telescope stays
-- for all of that (see plugins/telescope.lua).
vim.keymap.set("n", "<leader>sf", function()
	require("fff").find_files()
end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", function()
	require("fff").live_grep()
end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", function()
	require("fff").live_grep_under_cursor()
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sv", function()
	require("fff").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch Neo[V]im configuration files" })

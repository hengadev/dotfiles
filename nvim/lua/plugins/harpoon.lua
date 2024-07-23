local makeKey = require("utils.makeKey")
SetHarpoonKey = makeKey("Harpoon")

return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		SetHarpoonKey("<leader>ra", "<cmd>lua require('harpoon.mark').add_file()<cr>", "[A]dd to harpoon"),
		SetHarpoonKey( "<leader>ro", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "[T]oggle menu"),
		SetHarpoonKey("<C-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Open file number 1"),
		SetHarpoonKey("<C-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Open file number 2"),
		SetHarpoonKey("<C-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Open file number 3"),
		SetHarpoonKey("<C-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Open file number 4"),
	},
}

-- Correspondance dvorak et qwerty ? to do the remapping ?
--
-- old keymap to toggle the menu  "<C-e>"

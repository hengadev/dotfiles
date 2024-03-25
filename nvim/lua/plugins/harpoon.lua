local write_desc = function(desc)
    return "Harpoon: " .. desc
end

return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>",       desc = write_desc("[A]dd to harpoon") },
        { "<C-e>",     "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = write_desc("Toggle menu") },
        { "<C-1>",     "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = write_desc("Navigate to file [1]") },
        { "<C-2>",     "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = write_desc("Navigate to file [2]") },
        { "<C-3>",     "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = write_desc("Navigate to file [3]") },
        { "<C-4>",     "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = write_desc("Navigate to file [4]") },
    }
}

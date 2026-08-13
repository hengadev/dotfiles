-- plugins
vim.pack.add({
    "https://github.com/rcarriga/nvim-notify",
})

-- config
require("notify").setup({
    timeout = 2000,
    max_height = function() return math.floor(vim.o.lines * 0.75) end,
    max_width = function() return math.floor(vim.o.columns * 0.65) end,
    stages = "fade",
    top_down = false,
})

vim.notify = require("notify")

-- browse notification history via telescope (extension shipped by nvim-notify itself)
pcall(require("telescope").load_extension, "notify")

-- keymaps
vim.keymap.set("n", "<leader>nd", function()
    require("notify").dismiss({ silent = true, pending = true })
end, { desc = "[D]elete all [N]otifications" })

vim.keymap.set(
    "n",
    "<leader>ns",
    function() require("telescope").extensions.notify.notify({}) end,
    { desc = "[S]earch all [N]otifications" }
)

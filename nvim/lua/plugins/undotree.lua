return {
    {
        "mbbill/undotree",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            SetUndoKey("<leader>u", vim.cmd.UndotreeToggle, "Toggle [U]ndo tree"),
        },
    },
}

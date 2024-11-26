return {
    "nvim-neotest/neotest",
	event = {"BufReadPre", "BufNewFile"},
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        -- my adapters
        "marilari88/neotest-vitest",
		'thenbe/neotest-playwright',
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
    },
    config = function()
        -- adapters setup
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-vitest"),
				require('neotest-playwright').adapter({
					options = {
						persist_project_selection = true,
						enable_dynamic_test_discovery = true,
					},
				}),
                require("neotest-go"),
                require("neotest-rust"),
            },
            icons = {
                passed = "",-- the passed icon does not appear in golang
                failed = ""
            },
        })
        -- remapping
        local map = require("utils.map").set_prefix("Neotest")
        map("<leader>tr", neotest.run.run, "[R]un nearest [T]est")
        map("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "[T]est [F]ile")
        map("<leader>td", function() neotest.run.run({strategy = "dap"}) end, "[T]est [D]ebug")
        map("<leader>ts", neotest.run.stop, "[T]est [S]top")
        map("<leader>ta", neotest.run.attach, "[T]est [A]ttach to the nearesst test")
        map("<leader>to", neotest.output.open, "[T]est [O]utput")
        map("<leader>tO", function() neotest.output.open({ enter = true }) end, "[T]est [O]utput enter panel")
        map("<leader>tu", neotest.summary.toggle, "[T]est S[U]mmary")
        map("<leader>tl", neotest.run.run_last, "Run [L]ast [T]est")
        map("[f", neotest.run.run_last, "Go to previous [F]ailed test")
        map("f]", neotest.run.run_last, "Go to next [F]ailed test")
    end,
}

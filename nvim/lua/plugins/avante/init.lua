local mistral = require("lua.plugins.avante.providers.mistral")
-- local ollama = require("plugings.avante.providers.ollama")

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    -- NOTE: I could use telescope to pick the LLM that I want to use and make some extension to switch config
    opts = mistral,
    -- note: if you want to download pre-built binary, then pass source=false. make sure to follow instruction above.
    -- also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
    -- build = ":avantebuild source=false",
    build = "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "muniftanjim/nui.nvim",
        --- the below dependencies are optional,
        "echasnovski/mini.icons",
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        { -- support for image pasting
            "hakonharnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- make sure to set this up properly if you have lazy=true
            "meanderingprogrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "avante" },
            },
            ft = { "markdown", "avante" },
        },
    },
}

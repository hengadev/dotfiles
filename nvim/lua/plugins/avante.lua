return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {
        provider = 'mistral', -- recommend using claude
        vendors = {
            mistral = {
                -- __inherited_from = "openai",
                api_key_name = '',
                endpoint = "https://codestral.mistral.ai/v1",
                model = "codestral-latest",
                parse_curl_args = function(opts, code_opts)
                    return {
                        url = opts.endpoint .. "/chat/completions",
                        headers = {
                            ["accept"] = "application/json",
                            ["content-type"] = "application/json",
                            ['x-api-key'] = 't0tMdw46duZZQbMFjXYR7whmR3OGhbBx',
                        },
                        body = {
                            model = opts.model,
                            messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
                            max_tokens = 2048,
                            stream = true,
                        },
                    }
                end,
                parse_response_data = function(data_stream, event_state, opts)
                    require("avante.providers").openai.parse_response(data_stream, event_state, opts)
                end,
            },
        },

        -- note: old thing with local ollama
        -- provider = "ollama",
        -- -- use_absolute_path = true,
        -- vendors = {
        --     ollama = {
        --         -- ['local'] = true,
        --         api_key_name = '',
        --         endpoint = "127.0.0.1:11434/v1",
        --         model = "qwen2.5-coder:1.5b",
        --         parse_curl_args = function(opts, code_opts)
        --             return {
        --                 url = opts.endpoint .. "/chat/completions",
        --                 headers = {
        --                     ["accept"] = "application/json",
        --                     ["content-type"] = "application/json",
        --                     -- ['x-api-key'] = 'ollama',
        --                 },
        --                 body = {
        --                     model = opts.model,
        --                     messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
        --                     max_tokens = 2048,
        --                     stream = true,
        --                 },
        --             }
        --         end,
        --         parse_response_data = function(data_stream, event_state, opts)
        --             require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        --         end,
        --     },
        -- },
    },
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
        {
            -- support for image pasting
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

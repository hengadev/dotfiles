-- TODO: use the following general mistral api key : JnRl0HlPPPikHEnsyiEMiDJtg0uSu7Vw
-- or the codestral one : t0tMdw46duZZQbMFjXYR7whmR3OGhbBx
return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {
        provider = "mistral", -- Recommend using Claude
        vendors = {
            mistral = {
                -- ['local'] = true,
                api_key_name = '',
                endpoint = "https://codestral.mistral.ai/v1",
                model = "codestral-latest",
                parse_curl_args = function(opts, code_opts)
                    return {
                        url = opts.endpoint .. "/chat/completions",
                        headers = {
                            ["Accept"] = "application/json",
                            ["Content-Type"] = "application/json",
                            ['X-API-KEY'] = 't0tMdw46duZZQbMFjXYR7whmR3OGhbBx',
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

        -- NOTE: old thing with local ollama
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
        --                     ["Accept"] = "application/json",
        --                     ["Content-Type"] = "application/json",
        --                     -- ['X-API-KEY'] = 'ollama',
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
    -- NOTE: if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
    -- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
    -- build = ":AvanteBuild source=false",
    build = "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.icons",
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}

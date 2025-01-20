return {
    provider = "ollama",
    -- use_absolute_path = true,
    vendors = {
        ollama = {
            -- ['local'] = true,
            api_key_name = '',
            endpoint = "127.0.0.1:11434/v1",
            model = "qwen2.5-coder:1.5b",
            parse_curl_args = function(opts, code_opts)
                return {
                    url = opts.endpoint .. "/chat/completions",
                    headers = {
                        ["accept"] = "application/json",
                        ["content-type"] = "application/json",
                        -- ['x-api-key'] = 'ollama',
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
}

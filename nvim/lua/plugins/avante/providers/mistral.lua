return {
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
}

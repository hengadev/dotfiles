-- TODO: finis that configuration using your domain name for that
return {
    provider = 'deepseek',
    vendors = {
        mistral = {
            __inherited_from = "openai",
            -- TODO: accomodate that to fit previous line
            api_key_name = '',
            endpoint = "https://ai.henga.dev",
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

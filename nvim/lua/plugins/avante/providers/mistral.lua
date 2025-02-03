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
                -- the context seems to work, but I do not get any stream here
                local ctx = {}
                -- Debugging prints
                print("ctx: ", vim.inspect(ctx))
                print("data_stream:", vim.inspect(data_stream))
                print("event_state:", vim.inspect(event_state))
                print("opts:", vim.inspect(opts))

                require("avante.providers").openai.parse_response(ctx, data_stream, event_state, opts)
            end,
        },
    },
}

-- curl -X POST "https://codestral.mistral.ai/v1/chat/completions" \
--      -H "Content-Type: application/json" \
--      -H "x-api-key: t0tMdw46duZZQbMFjXYR7whmR3OGhbBx" \
--      -d '{
--          "model": "codestral-latest",
--          "messages": [{"role": "user", "content": "Hello, how are you?"}],
--          "max_tokens": 2048,
--          "stream": true
--      }'

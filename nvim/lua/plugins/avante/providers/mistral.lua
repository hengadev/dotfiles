return {
    __inherited_from = "openai",
    api_key_name = 'MISTRAL_API_KEY',
    endpoint = "https://codestral.mistral.ai/v1",
    -- endpoint = "https://codestral.mistral.ai/v1/chat/completions",
    model = "codestral-latest",
    extra_request_body = {
        max_tokens = 4096,
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

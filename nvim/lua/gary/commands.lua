-- TODO : add commands for my front and back end experience and other languages
-- Cette config vient de vim salesman.

local build_commands = {
    -- TODO: use clang to compile ?
    c = "g++ -std=c++17 -o %:p:r.o %",
    cpp = "g++ -std=c++17 -Wall -O2 -o %:p:r.o %",
    rust = "cargo build --release",
    go = "go build -o %:p:r.o %",
    typescript = "tsc %:p:r.ts"
}

local debug_build_commands = {
    c = "g++ -std=c++17 -g -o %:p:r.o %",
    cpp = "g++ -std=c++17 -g -o %:p:r.o %",
    rust = "cargo build",
    go = "go build -o %:p:r.o %",
    typescript = "tsc %:p:r.ts"
}

local run_commands = {
    c = "%:p:r.o",
    cpp = "%:p:r.o",
    rust = "cargo run --release",
    go = "%:p:r.o",
    typescript = "node %:p:r.js",
    javascript = "node %:p:r.js",
    python = "python3 %:p:r.py",
    java = "java %:p:r.java"
}

vim.api.nvim_create_user_command("Build", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(build_commands) do
        if (filetype == file) then
            vim.cmd("!" .. command)
            break
        end
    end
end, {})

vim.api.nvim_create_user_command("DebugBuild", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(debug_build_commands) do
        if (filetype == file) then
            vim.cmd("!" .. command)
            break
        end
    end
end, {})

vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(run_commands) do
        if (filetype == file) then
            vim.cmd("sp")
            vim.cmd("term " .. command)
            vim.cmd("resize 20N")
            local keys = vim.api.nvim_replace_termcodes("i", true, false, true)
            vim.api.nvim_feedkeys(keys, "n", false)
            break
        end
    end
end, {})

vim.api.nvim_create_user_command("Ha", function()
    vim.cmd [[Build]]
    vim.cmd [[Run]]
end, {})

vim.api.nvim_create_user_command("Config",
    function() vim.cmd [[cd ~/.config/nvim]] end,
    {})

vim.api.nvim_create_user_command("Cn", function()
    vim.cmd [[CocCommand rust-analyzer.reload]]
end, {})


-- NOTE: On teste un truc avec lazygit pour creer une nouvelle commande.
-- vim.api.nvim_create_user_command("LazyGit", function()
--     vim.cmd [[LazyGit]]
-- end, {})

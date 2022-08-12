local M = {}
function M.setup()
    local dap = require('dap')
    vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

    ----------------------------  Adapters -----------------------------------

    -- codelldb
    local cmd = vim.fn.stdpath('data') .. '/debuggers/codelldb/extension/adapter/codelldb'

    dap.adapters.codelldb = function(on_adapter)
        -- This asks the system for a free port
        local tcp = vim.loop.new_tcp()
        tcp:bind('127.0.0.1', 0)
        local port = tcp:getsockname().port
        tcp:shutdown()
        tcp:close()

        -- Start codelldb with the port
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local opts = {
            stdio = { nil, stdout, stderr },
            args = { '--port', tostring(port) },
        }
        local handle
        local pid_or_err
        handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                print("codelldb exited with code", code)
            end
        end)
        if not handle then
            vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
            stdout:close()
            stderr:close()
            return
        end
        vim.notify('codelldb started. pid=' .. pid_or_err)
        stderr:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end)
        local adapter = {
            type = 'server',
            host = '127.0.0.1',
            port = port
        }
        -- 💀
        -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
        -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
        vim.defer_fn(function() on_adapter(adapter) end, 5000)
    end

    --cppdbg
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/debuggers/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }


    --------------------------- configurations ---------------------------

    --- Java
    dap.configurations.java = {
        {
            type = 'java',
            name = "Java Launch",
            request = 'launch',
            -- projectName = projectName or nil,
            program = "${file}",
            hostName = "127.0.0.1",
            port = 8000
        },
    }


    -- cpp
    dap.configurations.cpp = {
        {
            name = "[codelldb] Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = true,
        },
        {
            name = "[cppdbg] Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEnsetupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            }, try = true,
        },
        {
            name = 'Attach to gdbserver :9890',
            type = 'cppdbg',
            request = 'attach',
            MIMode = 'gdb',
            miDebuggerServerAddress = 'localhost:9890',
            miDebuggerPath = '/usr/bin/gdb',
            cwd = '${workspaceFolder}',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            },
        },
    }


    -- C
    dap.configurations.c = dap.configurations.cpp

    -- rust
    dap.configurations.rust = dap.configurations.cpp
    dap.configurations.rust[1].sourceLanguages = { 'rust' }

    -------------------------------- keymapping --------------------------------------

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>zb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.keymap.set('n', '<space>zc', "<cmd>lua require'dap'.continue()<cr>", opts)
    vim.keymap.set('n', '<space>zo', "<cmd>lua require'dap'.step_over()<cr>", opts)
    vim.keymap.set('n', '<space>zi', "<cmd>lua require'dap'.step_into()<cr>", opts)
    vim.keymap.set('n', '<space>zr', "<cmd>lua require'dap'.repl.toggle()<cr>", opts)

end

return M

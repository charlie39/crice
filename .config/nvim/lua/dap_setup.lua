local M = {}
function M.setup()
    local dap = require('dap')
    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

    ---------------------------- Java ----------------------------------
--[[
     local util = require('jdtls.util')

    dap.adapters.java = function(callback)
        util.execute_command({ command = 'vscode.java.startDebugSession' }, function(err0, port)
            assert(not err0, vim.inspect(err0))
            -- print("puerto:", port)
            callback({
                type = 'server';
                host = '127.0.0.1';
                port = port;
            })
        end)
    end
]]
    -- local projectName = os.getenv('PROJECT_NAME')
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


    ------------------------------ cpp ------------------------------

    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/debuggers/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
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
            request = 'launch',
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

    ----------------------------------- c ----------------------------------------------

    dap.configurations.c = dap.configurations.cpp

    -------------------------------- keymapping --------------------------------------

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>zb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.keymap.set('n', '<space>zc', "<cmd>lua require'dap'.continue()<cr>", opts)
    vim.keymap.set('n', '<space>zo', "<cmd>lua require'dap'.step_over()<cr>", opts)
    vim.keymap.set('n', '<space>zi', "<cmd>lua require'dap'.step_into()<cr>", opts)
    vim.keymap.set('n', '<space>zr', "<cmd>lua require'dap'.repl.toggle()<cr>", opts)

end

return M

local M = {}

function M.ssetup()

    --loading dap ui like this gives setup called twice error
    require("dapui").setup()

    local opts = { noremap = true, silent = true }

    --[[ vim.keymap.set('n','<leader>do','<cmd>lua require("dapui").open()<cr>',opts )
    vim.keymap.set('n','<leader>dc','<cmd>lua require("dapui").close()<cr>',opts ) ]]

    -- vim.keymap.set('n', '<leader>dl', '<cmd>lua require("dapui").setup()<cr>', opts)
    vim.keymap.set('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<cr>', opts)


    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- For elements that are not opened in the tray or sidebar, you can open them in a floating window.

    vim.keymap.set('n', '<leader>1',
        '<cmd>lua require("dapui").float_element( console,{ width = 300, height = 100 })<cr>', opts)


    -- eval in floating window
    vim.keymap.set('v', '<C-k>', '<Cmd>lua require("dapui").eval()<CR>', opts)
end

return M

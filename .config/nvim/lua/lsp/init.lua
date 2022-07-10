-- lsp installer
require('nvim-lsp-installer').setup()

-- ========================== |  lspconfig  | ==================================

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
    print("from side on_attachh")
    --setup debug adapters
    require 'dap_setup'.setup()

    -- dap-ui config
    require 'dap-ui_setup'.ssetup()

    -- lsp installer

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<space>h', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('n', '<space>f', vim.lsp.buf.range_formatting, bufopts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then

        local hi = vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = 0,
            command = 'lua vim.lsp.buf.document_highlight()',
            desc = "highlight keywords under cursor",
            group = hi
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = 0,
            command = 'lua vim.lsp.buf.clear_references()',
            desc = "highlight keywords under cursor",
            group = hi
        })

        -- too brighty
        --[[ vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        , false) ]]
    end
    local hp = client.server_capabilities.hoverProvider
    if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    end
    local status_ok, galaxyline = pcall(require, 'galaxyline')
    if status_ok then
        local colors = require 'galaxyline.theme'.default
        galaxyline.section.mid[1] = {
            ShowLspClient = {
                highlight = { colors.orange, colors.bg, 'bold' },
                icon = ' LSP:',
                provider = function() return client.name end,
            },
        }
    end
    if client.name == "sumneko_lua" then
        require('lsp.osv').setup()
    end

end

-- Setup cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--------------------------------- Lua -------------------------------------

require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you are using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true, },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities
}

------------------------------- Bash  --------------------------------

require('lspconfig')['bashls'].setup {
    cmd_env = {
        GLOB_PATTERN = "*@(.sh|.inc|.bash|.zsh|.command)",
    },
    filetypes = { "sh", "zsh" },
    on_attach = on_attach,
    capabilities = capabilities
}

------------------------------- Python --------------------------------

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities
}


-------------------------------- Rust ----------------------------------
--
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    filetypes = { "rust" },
    capabilities = capabilities
}
------------------------------- clangd ---------------------------------

require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

local M = {}

M.on_attach = function(client, bufnr)
  local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local opts = { noremap = true, silent = true }

  --dap configuration, basically keymappings
  require('dap_setup').setup()

  -- dap-ui
  require('dap-ui_setup').ssetup()

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- Mappings.on_a
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

  if client.name == "jdt.ls" then
    -- extended features of jdtls
    vim.keymap.set('n', '<space>o', "<cmd>lua require('jdtls').organize_imports()<cr>", bufopts)
    vim.keymap.set('n', '<space>cv', "<cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
    vim.keymap.set('v', '<space>cv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
    vim.keymap.set('n', '<space>cc', "<cmd>lua require('jdtls').extract_constant()<cr>", bufopts)
    vim.keymap.set('v', '<space>cc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", bufopts)
    vim.keymap.set('v', '<space>cm', "<esc><cmd>require('jdtls').extract_method(true)<cr>", bufopts)

    -- If using nvim-dap
    vim.keymap.set('n', '<space>tc', "<cmd>lua require('jdtls').test_class()<cr>", bufopts)
    vim.keymap.set('n', '<space>tm', "<cmd>lua require('jdtls').test_nearest_method(true)<cr>", bufopts)

    require('jdtls').setup_dap()
    -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    -- require'jdtsl.dap'.setup_dap_main_class_configs()
    -- add the preconfigured Jdt* commands
    require('jdtls.setup').add_commands()

  end
  -- launch one-small-step-for-vimkind if the client is lua
  if client.name == "sumneko_lua" then
    require('lsp.osv').setup()
  end

  --telescope
  vim.keymap.set('n', '<space>wd', ':lua require"telescope.builtin".diagnostics()<cr>', bufopts)
  vim.keymap.set('n', '<space>gr', ':lua require"telescope.builtin".lsp_references()<cr>',bufopts)

  if client.server_capabilities.documentSymbolProvider then
    vim.keymap.set('n', '<space>ds', '<cmd>Telescope lsp_document_symbols<cr>', bufopts)
  end
  if client.server_capabilities.workspaceSymbolProvider then
    vim.keymap.set('n', '<space>ws', '<cmd>Telescope  lsp_workspace_symbols<cr>', bufopts)
  end

  --- lspsaga
  local lspsaga_ok, _ = pcall(require, 'lspsaga')
  if lspsaga_ok then
    vim.keymap.set('n', '<space>rn', require'lspsaga.rename'.lsp_rename, bufopts)
    vim.keymap.set('n', '<space>pd', require'lspsaga.definition'.preview_definition, bufopts)
    vim.keymap.set('n', '<space>sh', require'lspsaga.signaturehelp'.signature_help, bufopts)
    vim.keymap.set('v', '<space>ra', '<cmd>Lspsaga range_code_action<cr>', bufopts)
    vim.keymap.set('n', '<space>sf', '<cmd>Lspsaga lsp_finder<cr>', bufopts)

    vim.keymap.set('n', '<space>cD', require'lspsaga.diagnostic'.show_line_diagnostics,
      { silent = true, noremap = true })

    -- jump diagnostic
    vim.keymap.set("n", "[e", require'lspsaga.diagnostic'.goto_prev, bufopts)
    vim.keymap.set("n", "]e", require'lspsaga.diagnostic'.goto_next, bufopts)
    -- or jump to error
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })

    vim.keymap.set("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", bufopts)
    vim.keymap.set("t", "<A-t>", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", bufopts)
  end


  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.keymap.set('v', '<space>f', vim.lsp.buf.range_formatting, bufopts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local highlight = vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      command = 'lua vim.lsp.buf.document_highlight()',
      desc = "highlight text when cursor holds",
      group = highlight
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      command = 'lua vim.lsp.buf.clear_references()',
      desc = "clear references when cursor moves",
      group = highlight
    })
  end

  --galaxyline
  local status_ok, galaxyline = pcall(require, 'galaxyline')
  if status_ok then
    local lsp_updater = function()
      galaxyline.section.mid[1] = {
        ShowLspClient = {
          icon = ' LSP:',
          provider = function() return client.name end,
        },
      }
    end
    lsp_updater()
    local lsp_update = vim.api.nvim_create_augroup("lsp_update", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = bufnr,
      callback = lsp_updater,
      desc = "update lsp",
      group = lsp_update
    })
  end

  --UI
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
  local hp = client.server_capabilities.hoverProvider
  if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

    local diagnostic = vim.api.nvim_create_augroup("autoDiagnostic", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opt = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opt)
      end,
      group = diagnostic
    })
  end

  local signs = { Error = "❌", Warn = "⚠", Hint = "", Info = "ℹ" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.diagnostic.config({
    virtual_text = {
      prefix = '=>>',
    }
  })

  --codelens
  local cl = client.server_capabilities.codeLensProvider
  if cl == true or (type(cl) == "table" and next(cl) ~= nil) then
    vim.keymap.set('n', '<space>cd', vim.lsp.codelens.display, bufopts)
    vim.keymap.set('n', '<space>cf', vim.lsp.codelens.refresh, bufopts)
    vim.keymap.set('n', '<space>cr', vim.lsp.codelens.run, bufopts)
    vim.keymap.set('n', '<space>cg', vim.lsp.codelens.get, bufopts)
    vim.keymap.set('n', '<space>cs', vim.lsp.codelens.save, bufopts)
  end
  --- update galaxyline -----
  -- jdtls takes a retarted amount of time to start and galaxyline doesn't have any callback
  -- so this settings basically updates the provider of the lsp section with the client.name


end

return M

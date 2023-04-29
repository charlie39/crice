local M = {}

M.on_attach = function(client, bufnr)
  local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local opts = { noremap = true, silent = true }

  --dap configuration, basically keymappings
  require('dap_setup').setup()


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
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  if client.name == "jdtls" then
    -- extended features of jdtls
    vim.keymap.set('n', '<space>o', "<cmd>lua require('jdtls').organize_imports()<cr>", bufopts)
    vim.keymap.set('n', '<space>cv', "<cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
    vim.keymap.set('v', '<space>cv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", bufopts)
    vim.keymap.set('n', '<space>cc', "<cmd>lua require('jdtls').extract_constant()<cr>", bufopts)
    vim.keymap.set('v', '<space>cc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", bufopts)
    vim.keymap.set('v', '<space>cm', "<esc><cmd>require('jdtls').extract_method(true)<cr>", bufopts)

    --discover main classes
    vim.keymap.set('v', '<space>mc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", bufopts)

    -- If using nvim-dap
    vim.keymap.set('n', '<space>tc', "<cmd>lua require('jdtls').test_class()<cr>", bufopts)
    vim.keymap.set('n', '<space>tm', function() require('jdtls.dap').setup_dap_main_class_configs() end, bufopts)

    -- require('jdtls').setup_dap()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    -- require'jdtsl.dap'.setup_dap_main_class_configs()
    -- add the preconfigured Jdt* commands

  require('jdtls.setup').add_commands()
  end

  -- launch one-small-step-for-vimkind if the client is lua
  if client.name == "lua_ls" then
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
    vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<cr>', bufopts)
    vim.keymap.set('n', '<space>rnn', '<cmd>Lspsaga rename ++project<cr>', bufopts)
    vim.keymap.set('n', '<space>pd', '<cmd>Lspsaga peek_definition<cr>', bufopts)
    vim.keymap.set('n', '<space>pt', '<cmd>Lspsaga peek_type_definition<cr>', bufopts)
    vim.keymap.set('n', '<space>gD', '<cmd>Lspsaga goto_type_definition<cr>', bufopts)
    vim.keymap.set('n', '<space>sf', '<cmd>Lspsaga lsp_finder<cr>', bufopts)
    vim.keymap.set({"n","v"}, "<space>ca", "<cmd>Lspsaga code_action<cr>",bufopts)
    -- diagnostics

    vim.keymap.set('n', '<space>ld', '<cmd>Lspsaga show_line_diagnostics<cr>',bufopts)
    vim.keymap.set('n', '<space>cd', '<cmd>Lspsaga show_cursor_diagnostics<cr>',bufopts)
    vim.keymap.set('n', '<space>bd', '<cmd>Lspsaga show_buf_diagnostics<cr>',bufopts)
    -- jump diagnostic
    vim.keymap.set("n", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "[e",bufopts)
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>",bufopts)
    -- or jump to error
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })

    -- toggle outline
    vim.keymap.set("n","<space>0", "<cmd>Lspsaga outline<cr>",bufopts)
    -- toggle float window
    vim.keymap.set({"n","t"}, "<A-t>", "<cmd>Lspsaga term_toggle<CR>", bufopts)
    -- hover doc
     vim.keymap.set("n","K","<cmd>Lspsaga hover_doc<cr>",bufopts)
     -- keep hover window top right corner
     -- <C-w>w to jump to hover window
     vim.keymap.set("n","<space>K","<cmd>Lspsaga hover_doc ++keep<cr>",bufopts)

     -- call hierarchy
     vim.keymap.set("n","<space>ci","<cmd>Lspsaga incoming_calls<cr>",bufopts)
     vim.keymap.set("n","<space>co","<cmd>Lspsaga outgoing_calls<cr>",bufopts)
  end

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  end
  -- if client.server_capabilities.documentRangeFormattingProvider then
    -- vim.keymap.set('v', '<space>f', vim.lsp.buf.range_formatting, bufopts)
  -- end

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

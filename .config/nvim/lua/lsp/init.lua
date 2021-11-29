--setting up keybindings and options for lsp-----------------------------------------

--lsp-status
local lsp_status = require('lsp-status')
lsp_status.config {
  kind_labels =  vim.g.completion_customize_lsp_label,
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end,
  status_symbol = '$'
}

----lspconfig
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
     lsp_status.register_progress()
     lsp_status.on_attach(client)
       local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
       local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
       local opts = { noremap=true, silent=true }

         buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

         -- vim.api.nvim.set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
         -- Mappings.
         buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
         buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
         buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
         buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
         buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
         buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
         buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
         buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
         buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
         buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
         buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
         buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
         buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
         buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
         buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
         buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
         -- Set some keybinds conditional on server capabilities
         if client.resolved_capabilities.document_formatting then
           buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
         elseif client.resolved_capabilities.document_range_formatting then
           buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
         end
         -- Set autocommands conditional on server_capabilities
         if client.resolved_capabilities.document_highlight then
           vim.api.nvim_exec([[
             hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
             hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
             hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
             augroup lsp_document_highlight
               autocmd! * <buffer>
               autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
               autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
         augroup END
       ]], false)
 end
end
--LUA ------------------------------------------------------------------------------------------------------------------------------------------

local lua_root = vim.fn.stdpath('config')..'/plugged/lua-language-server'
local lua_binary = lua_root..'/bin/Linux/lua-language-server'

-- require'lspconfig'.sumneko_lua.setup {
nvim_lsp['sumneko_lua'].setup {
    on_attach = on_attach,
      cmd = {lua_binary, "-E", lua_root.. "/main.lua"},
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
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
      capabilities = lsp_status.capabilities
}

--bash ------------------------------------------------------------------------------------------------------------------------------------------------
nvim_lsp['bashls'].setup{
      cmd_env = {
         GLOB_PATTERN = "*@(.sh|.inc|.bash|.zsh|.command)",
      },
      filetypes = { "sh", "zsh" },
      on_attach = on_attach,
      capabilities = lsp_status.capabilities
}
---python -------------------------------------------------------------------------------------------------------------------------------------------
nvim_lsp['pyright'].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

--java -----------------------------------------------------------------------------------------------------------------------------------------------
--[[ require'lspconfig'.jdtls.setup{
    -- cmd = { "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx2G", "-jar", "vim.NIL", "-configuration", "vim.NIL", "-data", "vim.NIL", "--add-modules=ALL-SYSTEM", "--add-opens java.base/java.util=ALL-UNNAMED", "--add-opens java.base/java.lang=ALL-UNNAMED" },
    -- cmd = { "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx2G","--add-modules=ALL-SYSTEM" },
    cmd = { "java-lsp" },
    cmd_env = {
      JAR = "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    JDTLS_CONFIG = "/usr/share/java/jdtls/config_linux"
    },
    filetypes = { "java" },
    init_options = {
      -- jvm_args = {}
      workspace = "/home/charlie/trash/java"
    },
    -- root_dir = root_pattern(".git")
} ]]
vim.cmd[[source ~/.config/nvim/conf/lsp_status.vim]]

-- ========================== |  lspconfig  | ==================================

-- Setup cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- attach the on_attach function
local on_attach = require 'lsp.on_attach'.on_attach

local on_init = function(client, _)
  client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
end
------------------------- lua ---------------------------------
require('lspconfig')['lua_ls'].setup {
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
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
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

--[[ require('lspconfig')['bashls'].setup {
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.zsh|.command)",
  },
  filetypes = { "sh", "zsh" },
  on_attach = on_attach,
  capabilities = capabilities
} ]]

------------------------------- Python --------------------------------

--[[ require('lspconfig')['pyright'].setup {
  on_attach = on_attach,
  capabilities = capabilities
}
 ]]

-------------------------------- Rust ----------------------------------

local rust_ok, rust = pcall(require, 'rust-tools')
if rust_ok then
  -- Update this path
  local extension_path = vim.fn.stdpath('data') .. '/debuggers/codelldb/extension/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

  local options = {

    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        codelldb_path, liblldb_path)
    }
  }
  rust.setup(options)
end
------------------------------- clangd ---------------------------------

local clangd_ok, clangd = pcall(require, 'clangd_extensions')
if clangd_ok then
  clangd.setup {
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init
    }
  }
end

-----------------------------ltex ------------------------------------
--[[
require('lspconfig')['ltex'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init
}
 ]]
--------------------------kotlin -----------------------------------------
--[[
require'lspconfig'.kotlin_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
} ]]

--------------------------csharp ------------------------------------
--[[ require('lspconfig')['omnisharp'].setup {
  on_attach = on_attach,
  capabilities = capabilities
} ]]

------------------------------markdown -------------------------------
--[[ require('lspconfig')['marksman'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
  root_dir = function() return vim.fn.getcwd() end
}
 ]]
----------------------------html -------------------------------------
require 'lspconfig'.html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

----------------------------- xml -------------------------------------

require 'lspconfig'.lemminx.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

------------------------------sqls-------------------------------------

require 'lspconfig'.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  --[[ settings = {
    sqlls = {
      connections = {
        {
          driver = 'mysql',
          dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
        },
        {
          driver = 'postgresql',
          dataSourceName = 'host=127.0.0.1 port=15432 user=postgres pas sword=mysecretpassword1234 dbname=dvdrental sslmode=disable',
        },
      },
    },
  }, ]]
}
------------------------gopls-----------------------------------------
--[[
require'lspconfig'.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
} ]]
-------------------------ymlls-----------------------------------------
--[[
require'lspconfig'.yamlls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
} ]]
------------------------------------------------------------------------

-- lspsaga --
-- this should at the bottom of all language servers
local ok_saga, lspsaga = pcall(require,'lspsaga')
if ok_saga then
  lspsaga.setup({})
end

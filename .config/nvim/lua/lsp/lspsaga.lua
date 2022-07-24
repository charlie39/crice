local M = {}

M.setup = function()

  local lspsaga_ok, lspsaga_ = pcall(require, 'lspsaga')
  if lspsaga_ok then
    lspsaga_.init_lsp_saga{
      symbol_in_winbar = {
        in_custom = true,
      },
      -- diagnostic_header = { " ", " ", " ", "ﴞ " },
      diagnostic_header = { "😡", "😥", "😤", "😐" },
      --[[ finder_icons = {
        def = '  ',
        ref = '諭 ',
        link = '  ',
      } ]]
    }
    local function get_file_name(include_path)
      local file_name = require('lspsaga.symbolwinbar').get_file_name()
      if vim.fn.bufname '%' == '' then return '' end
      if include_path == false then return file_name end
      local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'

      local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
      local file_path = ''
      for _, cur in ipairs(path_list) do
        file_path = (cur == '.' or cur == '~') and '' or
            file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
      end
      return file_path .. file_name
    end

    local function config_winbar()
      local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
      local sym
      if ok then sym = lspsaga.get_symbol_node() end
      local win_val = ''
      win_val = get_file_name(false) -- set to true to include path
      if sym ~= nil then win_val = win_val .. sym end
      vim.wo.winbar = win_val
    end

    -- WinLeave gives not enough error on lsp handler functions
    -- local events = { 'CursorHold', 'BufEnter', 'BufWinEnter', 'CursorMoved', 'User LspasgaUpdateSymbol' }
    local events = { 'User LspasgaUpdateSymbol' }

    local exclude = {
      ['terminal'] = true,
      ['prompt'] = true
    }

    vim.api.nvim_create_autocmd(events, {
      pattern = '*',
      callback = function()
        -- Ignore float windows and exclude filetype
        if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
          vim.wo.winbar = ''
        else
          config_winbar()
        end
      end,
    })
  end
end

return M

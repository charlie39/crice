local finders = {}
local home = os.getenv('HOME')

local with_preview = {
  windblend = 10,
  -- show_line = false,
  follow = true,
  prompt_prefix = "~>",
  results_title = false,
  preview_title = false,
  layout_config = {
    preview_width = 0.6,
  }
}

finders.nvim_conf = function(opts)
  local opt = vim.deepcopy(with_preview)
  if type(opts) == 'table' then
    opt = vim.tbl_deep_extend('force', opt, opts)
  end
  opt.prompt_prefix = "FD>"
  opt.prompt_title = "Nvim Config"
  opt.cwd = vim.fn.stdpath('config')
  require 'telescope.builtin'.fd(opt)
end


finders.generic_special = function(opts)
  local opt = vim.deepcopy(with_preview)
  opt.prompt_title = "Configs & Scripts"
  -- opt.find_command =  { "find", home .. '/.local/bin/', home .. '/packages/repos/', home .. '/.config/', home .. '/vimwiki', "-maxdepth", "4", "-type", "f" }
  opt.hidden = true
  -- opt.layout_strategy = 'vertical'
  opt.search_dirs = { home .. '/.local/bin/', home .. '/packages/repos/', home .. '/.config/', home .. '/vimwiki' }
  if type(opts) == 'table' then
    opt = vim.tbl_deep_extend('force', opt, opts)
  end
  require 'telescope.builtin'.find_files(opt)
end


finders.my_live_grep = function(opts)
  local opt = vim.deepcopy(with_preview)
  opt.prompt_title = "My Live Grep"
  opt.search_dirs = { home .. '/.local/bin/', home .. '/packages/repos/', home .. '/.config/', home .. '/vimwiki' }
  opt.additional_args = function()
    return { '-L','-Tlog' }
  end
  if type(opts) == 'table' then
    opt = vim.tbl_deep_extend('force',opt,opts)
  end
  require'telescope.builtin'.live_grep(opt)
end


return finders

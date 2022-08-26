--======= | DEFAULT OPTIONS || ======-----
vim.g.mapleader = ','
vim.wo.number = true
vim.wo.rnu = true
--shortcuts
---@diagnostic disable-next-line: unused-local
local cmd, fn, g, exe = vim.cmd, vim.fn, vim.g, vim.api.nvim_command
local opt = require('utils').opt
-- set guifont for gui vim ( neovide )
opt('o', 'guifont', 'FiraCode Nerd Font:h10')
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.execute({ '!git', 'clone', '--depth 1', 'https://github.com/wbthomason/packer.nvim', install_path })
  exe 'packadd packer.nvim'
end

-- plugin manager
-- if you want to use other plugin manager, comment it out
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'ellisonleao/glow.nvim', branch = 'main' }
  use { 'junegunn/fzf.vim', disable = true, opt = true,
    config = function() require('config.fzf') end,
    cmd = { 'LS', 'LSv', 'FZF', 'FZD' } }
  use { 'b3nj5m1n/Kommentary' }
  -- use { 'williamboman/nvim-lsp-installer' }
  use { 'neovim/nvim-lspconfig', config = function() require 'lsp' end }
  use { 'williamboman/mason.nvim',
    requires = { 'williamboman/mason-lspconfig.nvim', config = require 'mason-lspconfig'.setup() },
    config = require 'mason'.setup() }
  use { 'glepnir/lspsaga.nvim', branch = "main" }
  use { 'onsails/lspkind.nvim' }
  use { 'folke/trouble.nvim', opt = true }
  use { 'mfussenegger/nvim-jdtls', ft = { 'java' } }
  use { 'p00f/clangd_extensions.nvim', opt = true }
  use { 'simrat39/rust-tools.nvim', opt = true }

  use { 'glacambre/firenvim', opt = true,
    run = function() vim.fn['firenvim#install'](-1) end }

  use { 'kyazdani42/nvim-web-devicons' }
  use { 'glepnir/galaxyline.nvim', opt = true, branch = 'main',
    requires = 'kyazdani42/nvim-web-devicons' }
  use { 'akinsho/bufferline.nvim', opt = true,
    tag = "v2.*", wants = 'kyazdani42/nvim-web-devicons' }
  use { 'ray-x/aurora', opt = true }
  use { 'navarasu/onedark.nvim', opt = true }
  use { 'tiagovla/tokyodark.nvim', opt = true }
  use { 'chriskempson/base16-vim', opt = true }
  use { 'ap/vim-css-color', opt = true }

  use { 'tpope/vim-fugitive', opt = true }
  use { 'lewis6991/gitsigns.nvim', opt = true, }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate', config = function() require 'config.tsitter' end }
  use { 'nvim-treesitter/nvim-treesitter-refactor', opt = true }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true }
  use { 'p00f/nvim-ts-rainbow', opt = true }
  use { 'kylechui/nvim-surround', opt = true }
  use { 'mfussenegger/nvim-dap' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'jbyuki/one-small-step-for-vimkind', opt = true, requires = 'mfussenegger/nvim-dap',
    config = function() require 'lsp.osv' end, ft = { '.lua' } }
  use { 'mhartington/formatter.nvim', opt = true }

  use { 'L3MON4D3/LuaSnip',
    requires = { 'saadparwaiz1/cmp_luasnip',
      -- 'rafamadriz/friendly-snippets',
      'molleweide/LuaSnip-snippets.nvim',
    },
    config = function() require 'config.luasnip' end
  }
  -- use { '
  use { 'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua', requires = 'hrsh7th/nvim-cmp' }
  use { 'tzachar/cmp-tabnine', run = './install.sh',
    requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path' },
    wants = 'hrsh7th/cmp-nvim-lua',
    config = function() require 'config.cmp' end }

  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function() require('config.telescope') end }
  use { 'kevinhwang91/rnvimr', opt = true, cmd = 'RnvimrToggle' }
  use { 'kyazdani42/nvim-tree.lua', opt = true, keys = ',n',
    tag = 'nightly', config = function() require 'nvim-tree'.setup() end }
  use { 'charlie39/OneStop.nvim', branch = 'main', config = require 'onestop'.setup {
    terminal = { 'alacritty', '-e' }, layout = { width = 180, height = 48 }
  } }
end)


--================ BASICS ===================

-- require'onestop'.setup({ terminal = { 'kitty', '-e' }})
require 'onestop'.setup {
  terminal = { 'alacritty', '-e' },
  layout = {
    width = 140,
    height = 40,
  }
}

vim.keymap.set('n', '<C-\\>', ':PackerLoad<space><Tab>', { noremap = true })
vim.keymap.set('n', '<C-]>', ':packadd <space><Tab>', { noremap = true })

require('settings') -- --default settings
require('keymap') -- --keymappings


------plugin configs

-- require 'config.luasnip'


cmd 'packadd nvim-jdtls'
-- cmd 'packadd clangd_extensions.nvim'
-- cmd 'packadd nvim-treesitter-refactor'
cmd 'packadd nvim-treesitter-textobjects'
cmd 'packadd nvim-surround'
cmd 'packadd nvim-tree.lua'
cmd 'packadd vim-fugitive'

--merge 3 way conflict
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit!<cr>', opts)
vim.keymap.set('n', '<leader>gh', '<cmd>diffget //2<cr>', opts)
vim.keymap.set('n', '<leader>gl', '<cmd>diffget //3<cr>', opts)
vim.keymap.set('n', '<leader>gw', '<cmd>Gwrite<cr>', opts)
vim.keymap.set('n', '<leader>grc', '<cmd>Git rebase --continue<cr>', opts)
vim.keymap.set('n', '<leader>grs', '<cmd>Git rebase --skip<cr>', opts)
vim.keymap.set('n', '<leader>gra', '<cmd>Git rebase --abort<cr>', opts)

local tree_ok, tree = pcall(require, 'nvim-tree')
if tree_ok then
  tree.setup()
end

cmd 'packadd gitsigns.nvim'

local gs_ok, gss = pcall(require, 'gitsigns')
if gs_ok then
  gss.setup {
    -- numhl = true,
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end

      -- Navigation
      map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
      map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

      -- Actions
      map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
      map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
      map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
      map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
      map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
      map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
      map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
      map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
      map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

      -- Text object
      map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
end

local surround_ok, surround = pcall(require, 'nvim-surround')
if surround_ok then
  surround.setup({
    keymaps = {
      visual = "z",
    }
  })
end
-- cmd 'packadd one-small-step-for-vimkind'

if vim.g.neovide then
  require('config.neovide')
end


cmd 'packadd firenvim'
if vim.fn.empty(vim.g['started_by_firenvim']) == 1 then
  cmd 'packadd galaxyline.nvim'
  require 'config.galaxyline'
  cmd 'packadd bufferline.nvim'
  require 'bufferline'.setup {
    options = {
      separator_style = "padded_slant",
      numbers = "buffer_id",
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
    }
  }
else
  require 'config.firenvim'
end


--[[ cmd 'packadd trouble.nvim'

require 'trouble'.setup {
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
} ]]
--============ Functions =================

function Toggle_wrap()
  opt('w', 'breakindent', not vim.wo.breakindent)
  opt('w', 'linebreak', not vim.wo.linebreak)
  opt('w', 'wrap', not vim.wo.wrap)
end

-- commands
vim.api.nvim_create_user_command('Chdir', function(opts)
  vim.ui.input({ prompt = "Enter Path: ", completion = "file" }, function(input)
    if not vim.fn.isdirectory(vim.fn.glob(input)) then
      vim.notify("not a directory")
      return
    end
    vim.fn.chdir(input)
    -- TODO
    -- reload nvim tree explorer
    -- require'nvim-tree'.explorer.relaod()
  end)
end, { nargs = "?", complete = 'file' })

vim.keymap.set({ 'i', 'n' }, '<M-x>', '<cmd>Chdir<cr>', { noremap = true })



-- ============= AUTOCMDS =================

local custom = vim.api.nvim_create_augroup("custom", { clear = true })

vim.api.nvim_create_autocmd("CursorMovedI", {
  pattern = "*.tex",
  callback = function()
    local curpos = vim.fn.getcurpos()
    local position = string.format("%s:%s:%s ", curpos[2], curpos[3], vim.fn.expand('%:p'))
    local input = string.gsub(vim.fn.expand("%:p"), "tex$", "pdf")
    vim.fn.jobstart(string.format("zathura -x 'nvr --remote +%%{line} %%{input}' --synctex-forward %s %s", position,
      input))
  end,
  desc = "Open PDF in Zathura with syncpdf",
  group = custom
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
  pattern = "*.tex",
  command = "silent !compiler %",
  desc = "Compiles .tex files to pdf",
  group = custom,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    cmd 'setlocal nonumber norelativenumber'
    cmd 'setlocal nospell'
    cmd 'setlocal signcolumn=auto'
    cmd 'startinsert'
  end,
  desc = "CLean up on entering Terminal",
  group = custom
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = '*',
  command = "silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=300}",
  group = custom,
  desc = 'highlight yanked text'
})
-- jdtls
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  command = "lua require('lsp.jdtls_setup').setup()",
  desc = " Starts jdtls( Java language server )",
  group = custom
})


vim.tbl_map(function(c) cmd(string.format('autocmd  %s', c)) end, {
  'VimLeave *.tex silent !texclear %',
  'FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
  'BufWritePre * %s/\\s\\+$//e',
  -- 'BufWritepre * $s/\\n\\+\\%$//e',
  -- this removes all empty lines
  -- 'BufWritepre * %s/\\n\\+$//e',
  'BufWritePost files,directories,aliasrc !shortcuts && source ~/.config/shortcutrc',
  'BufWritePost *Xresources,*Xdefaults !xrdb %',
  'BufWritePost *sxhkdrc !pkill -USR1 sxhkd',
  'BufEnter *.xdefaults set filetype=xdefaults',
  'FileType xml,html set sts=2 shiftwidth=2',
})

------------------ Colorchemes -----------------------------

vim.cmd [[set bg=dark]]

--onedark
--[[ cmd 'packadd onedark.nvim'
local od = require('onedark')
od.setup {
  -- style = 'dark'
  -- style = 'darker',
  -- style = 'cool'
  style = 'deep'
  -- style = 'warm',
  -- style = 'warmer'
  -- transparent = true,
}
od.load() ]]

--tokyodark
cmd 'packadd tokyodark.nvim'
cmd 'colorscheme tokyodark'

-- aurora doesn't allow scope highlight from ts
--[[ cmd 'packadd aurora'
vim.g.aurora_italic = 1
cmd 'colorscheme aurora' ]]
-- cmd 'colorscheme base16-atelier-savanna'
-- cmd 'colorscheme base16-atelier-plateau'
-- cmd 'colorscheme base16-3024'
-- cmd 'colorscheme base16-woodland'


-- ts-rainbow should be loaded after colorscheme
cmd 'packadd nvim-ts-rainbow'
-- cmd 'if &diff then highlight! link DiffText MatchParent end'

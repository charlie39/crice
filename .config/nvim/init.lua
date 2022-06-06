-- neovim config
--default options
vim.g.mapleader = ','
vim.wo.number=true
vim.wo.rnu=true
vim.cmd [[set bg=light]]
--shortcuts
local cmd, fn, g, exe  =  vim.cmd, vim.fn, vim.g, vim.api.nvim_command
-- cmd 'colorscheme base16-black-metal-immortal'
cmd 'colorscheme base16-3024'
local opt = require('utils').opt
-- set guifont for gui vim
opt('o','guifont','FiraCode Nerd Font:h12')
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  exe 'packadd packer.nvim'
end
-------------------- PLUGIN SETUP --------------------------
--vim-rainbow
g['rainbow_active']=1
--ycm path to clagd
g['ycm_clangd_uses_ycmd_caching']=0
g['ycm_clangd_binary_path']='~/.config/nvim/packs/clangd/bin/clangd'

--vim-airline - powerline-fonts
g['airline_powerline_fonts']=1
g['airline#extensions#tabline#enabled']=1
g['airline_statusline_ontop']=1
g['airline_theme']='jet'
g['airline_detect_modified']=1     -- * enable modified detection
g['airline_detect_paste']=1        -- * enable paste detection
g['airline_detect_crypt']=1        -- * enable crypt detection
g['airline_detect_spell']=1        -- * enable spell detection
g['airline_detect_spelllang']=1    -- * display spelling language when spell detection is enabled if enough space is available
g['airline_detect_iminsert']=0     -- * enable iminsert detection
g['airline_inactive_collapse']=1   -- * determine whether inactive windows should have the left section collapsed to only the filename of that buffer.  >
g['airline_inactive_alt_sep']=1    -- * Use alternative seperators for the statusline of inactive windows >
 -- * define the set of text to display for each mode
 --[[ let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ } ]]
-- * define the set of names to be displayed instead of a specific filetypes (for section a and b):

  --[[ let g:airline_filetype_overrides = {
      \ 'coc-explorer':  [ 'CoC Explorer', '' ],
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
      \ } ]]

--vimkwiki
g['vimwiki_list'] = { path= '~/vimwiki', syntax= 'markdown', ext= '.md' }

-- treesitter
   --[[ require 'nvim-treesitter.configs'.setup {
	   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	   highlight = {
	     enable = true,              -- false will disable the whole extension
	  },
	} ]]

--=======================||  PLUGINS  ||=============================--
---| LSP |---
exe 'packadd nvim-lspconfig'
exe 'packadd lspkind-nvim'
exe 'packadd lspsaga.nvim'
exe 'packadd nvim-jdtls'
exe 'packadd nvim-dap'
exe 'packadd lsp-status.nvim'
-- exe 'packadd coc.nvim'

---| Movement |---
exe 'packadd telescope.nvim'
exe 'packadd telescope-fzy-native.nvim'
exe 'packadd fzf.vim'

--completer
-- exe 'packadd nvim-compe'
exe 'packadd YouCompleteMe'
require('ycmkeymap')

---| File Mgr |---
exe 'packadd rnvimr'
exe 'packadd vim-startify'
exe 'packadd vim-which-key'
exe 'packadd nerdtree'
exe 'packadd chadtree'
--exe 'packadd vimwiki'

exe 'packadd formatter.nvim'
exe 'packadd plenary.nvim'
exe 'packadd nvim-web-devicons'
exe 'packadd base16-vim'
exe 'packadd vim-surround'
exe 'packadd vim-rainbow'
exe 'packadd Kommentary'
exe 'packadd popfix'
exe 'packadd vim-css-color'
exe 'packadd vim-floaterm'
exe 'packadd firenvim'

exe 'packadd vim-bookmarks'
exe 'packadd nvim-treesitter'
exe 'packadd popup.nvim'
exe 'packadd nvim-cheat.sh'
exe 'packadd nvim-select-multi-line'
-- exe 'packadd vim-fugitive'

---| Themes |--
exe 'packadd vim-airline-themes'
exe 'packadd vim-airline'



-- FZF
g['fzf_action'] = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit',
}
--Lspsaga
-- local saga = require 'lspsaga'
-- saga.init_lsp_saga()
-- require('lspkind').init()

local map= require('utils').map
--multi-line
map('n', '<leader>v','<cmd>call sml#mode_on()<cr>', {noremap = true})


 -------------------- BASICS -------------------------------


--default settings
require('settings')

--plugins
require('plugins')


--keymappings
require('keymappings')



---------------SOURCE PLUGIN CONFIG------------------------------------

require('config.telescope')
require('config.fzf')
-- cmd 'source ~/.config/nvim/conf/fzf.vim'
require('config.dev-icon')
-- require('config.compe')
-- exe 'autocmd FleType java lua require("jdtls_setup").setup() autocmd END'
vim.api.nvim_exec([[
  augroup jdtls
    autocmd!
    autocmd FileType java lua require('jdtls_setup').setup()
  augroup end
]], false)

cmd 'source ~/.config/nvim/conf/which-key.vim'

require('lsp')
-------------------- COMMANDS ------------------------------
function Init_term()
  cmd 'setlocal nonumber norelativenumber'
  cmd 'setlocal nospell'
  cmd 'setlocal signcolumn=auto'
  cmd 'startinsert'
end

function Toggle_wrap()
  opt('w', 'breakindent', not vim.wo.breakindent)
  opt('w', 'linebreak', not vim.wo.linebreak)
  opt('w', 'wrap', not vim.wo.wrap)
end

vim.tbl_map(function(c) cmd(string.format('autocmd %s', c)) end, {
  'TermOpen * lua Init_term()',
  'TextYankPost * lua vim.highlight.on_yank {timeout = 200}',
  'TextYankPost * if v:event.operator is "y" && v:event.regname is "+" | OSCYankReg + | endif',

  'VimLeave *.tex !texclear %',
  'FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
  'BufWritePre * %s/\\s\\+$//e',
  'BufWritepre * $s/\\n\\+\\%$//e',
  'BufWritePost files,directories,aliasrc !shortcuts && source ~/.config/shortcutrc',
  'BufWritePost *Xresources,*Xdefaults !xrdb %',
  'BufWritePost *sxhkdrc !pkill -USR1 sxhkd',
})
-- cmd 'if &diff then highlight! link DiffText MatchParent end'
require('config.neovide')

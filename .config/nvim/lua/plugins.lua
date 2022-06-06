-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesnt have https://github.com/neovim/neovim/pull/12632 merged
 --vim._updte_package_paths()
 local plugin_path = vim.fn.stdpath('config')..'/plugged'
 local opts = { opt = true }

return require('packer').startup(function(use)


use { plugin_path..'/vim-surround' , opt = true  }
use { plugin_path..'/Kommentary' , opt = true  }
use { 'glacambre/firenvim', opt = true, run = function() vim.fn['firenvim#install'](0) end }
use { 'nvim-lua/lsp-status.nvim', opt = true }
use { plugin_path..'/fzf.vim' , opt = true  }
use { plugin_path..'/base16-vim' , opt = true  }
use { plugin_path..'/vim-css-color' , opt = true  }
use { plugin_path..'/vim-airline' , opt = true  }
use { plugin_path..'/vim-airline-themes' , opt = true  }
-- vim lsp-config
use { plugin_path..'/nvim-lspconfig' , opt = true  }
use { plugin_path..'/lspkind-nvim' , opt = true  }
use { plugin_path..'/lspsaga.nvim' , opt = true  }
-- or

use { plugin_path..'/nvim-jdtls' , opt = true  }
use { plugin_path..'/formatter.nvim' , opt = true  }
use { plugin_path..'/nvim-dap' , opt = true  }
use { plugin_path..'/popup.nvim' , opt = true  }
use { plugin_path..'/plenary.nvim' , opt = true  }
use { plugin_path..'/telescope-fzy-native.nvim' , opt = true  }
use { plugin_path..'/telescope.nvim' , opt = true  }
use { plugin_path..'/nvim-treesitter', cmd = 'TSUpdate' , opt = true  }
use { plugin_path..'/nvim-web-devicons' , opt = true  }
use { plugin_path..'/vim-rainbow' , opt = true  }
use { plugin_path..'/vim-bookmarks' , opt = true  }
use { plugin_path..'/vim-which-key' , opt = true , }
use { plugin_path..'/vimwiki' ,opt = true  }
use { plugin_path..'/nvim-compe' ,opt = true  }
use { plugin_path..'/popfix' ,opt = true  }
use { plugin_path..'/nvim-cheat.sh' , opt = true  }

use { plugin_path..'/nerdtree' , opt = true  }
use { plugin_path..'/vim-startify' , opt = true  }
use { plugin_path..'/YouCompleteMe' , opt = true  }
use { plugin_path..'/coc.nvim', opt = true }
use { plugin_path..'/chadtree', opt = true }
use { plugin_path..'/vim-commentary' , opt = true  }
use { plugin_path..'/ale' , opt = true  }
use { plugin_path..'/goyo.vim' , opt = true  }
use { plugin_path..'/i3-vim-syntax' , opt = true  }
use { plugin_path..'/vimling' , opt = true  }
use { plugin_path..'/vimagit' , opt = true  }
use { plugin_path..'/vifm.vim' , opt = true  }
use { plugin_path..'/vim-javascript' , opt = true  }
use { plugin_path..'/vim-gitgutter'  , opt = true  }
use { 'Rasukarusan/nvim-select-multi-line', opt = true }
use { 'kevinhwang91/rnvimr' , opt = true }
use { plugin_path..'/vim-fugitive', opt =true }
use { 'voldikss/vim-floaterm' , opt = true}

end)

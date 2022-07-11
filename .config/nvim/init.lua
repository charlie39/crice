--======= || DEFAULT OPTIONS || ======-----

vim.g.mapleader = ','
vim.wo.number = true
vim.wo.rnu = true
vim.cmd [[set bg=light]]
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
    use { 'glacambre/firenvim', opt = true,
        run = function() vim.fn['firenvim#install'](-1) end ,
        config = function() require'config.firenvim' end }

    use { 'junegunn/fzf.vim', opt = true,
        config = function() require('config.fzf') end,
        cmd = { 'LS', 'LSv', 'FZF', 'FZD' } }

    use { 'b3nj5m1n/Kommentary' }

    use { 'williamboman/nvim-lsp-installer' }
    use { 'neovim/nvim-lspconfig', config = function() require 'lsp' end }
    use { 'glepnir/lspsaga.nvim', branch = "main" }
    use { 'onsails/lspkind.nvim' }
    use { 'mfussenegger/nvim-jdtls', ft = { 'java' } }

    use { 'kyazdani42/nvim-web-devicons' }
    use { 'glepnir/galaxyline.nvim', branch = 'main',
        config = function() require 'config.galaxyline' end,
        requires = 'kyazdani42/nvim-web-devicons' }
    use { 'akinsho/bufferline.nvim', tag = "v2.*", wants = 'kyazdani42/nvim-web-devicons' }
    use { 'ray-x/aurora', opt = true }
    use { 'chriskempson/base16-vim', opt = true }
    use { 'ap/vim-css-color', opt = true }

    use { 'tpope/vim-fugitive', opt = true }

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate', config = function() require 'config.tsitter' end }
    use { 'nvim-treesitter/nvim-treesitter-refactor', opt = true }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true }
    use { 'p00f/nvim-ts-rainbow', opt = true }

    use { 'mfussenegger/nvim-dap' }
    use { 'rcarriga/nvim-dap-ui' }
    use { 'jbyuki/one-small-step-for-vimkind', opt = true, requires = 'mfussenegger/nvim-dap',
        config = function() require 'lsp.osv' end, ft = { '.lua' } }

    use { 'mhartington/formatter.nvim', opt = true }

    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }
    use { 'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', requires = 'hrsh7th/nvim-cmp' }
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

end)


--================ BASICS ===================

vim.keymap.set('n', '<C-\\>', ':PackerLoad<space><Tab>', { noremap = true })
vim.keymap.set('n', '<C-]>', ':packadd <space><Tab>', { noremap = true })
-- cmd 'packadd firenvim'
cmd 'packadd nvim-jdtls'
-- exe 'packadd one-small-step-for-vimkind'

require('settings') -- --default settings
require('keymap') -- --keymappings

if vim.g.neovide then
    require('config.neovide')
end

--=========  PLUGIN CONFIG ================
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
--============ Functions =================

function Toggle_wrap()
    opt('w', 'breakindent', not vim.wo.breakindent)
    opt('w', 'linebreak', not vim.wo.linebreak)
    opt('w', 'wrap', not vim.wo.wrap)
end

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
vim.api.nvim_create_autocmd("FileType Java", {
    pattern = 'java',
    command = "lua require('lsp.jdtls_setup').setup()",
    desc = " Starts jdtls( Java language server )",
    group = custom
})

vim.tbl_map(function(c) cmd(string.format('autocmd  %s', c)) end, {
    'VimLeave *.tex silent !texclear %',
    'FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
    'BufWritePre * %s/\\s\\+$//e',
    'BufWritepre * $s/\\n\\+\\%$//e',
    'BufWritePost files,directories,aliasrc !shortcuts && source ~/.config/shortcutrc',
    'BufWritePost *Xresources,*Xdefaults !xrdb %',
    'BufWritePost *sxhkdrc !pkill -USR1 sxhkd',
})

cmd 'colorscheme aurora'
-- cmd 'colorscheme base16-atelier-savanna'
-- cmd 'colorscheme base16-atelier-plateau'
-- cmd 'colorscheme base16-3024'
-- cmd 'colorscheme base16-woodland'
-- cmd 'if &diff then highlight! link DiffText MatchParent end'

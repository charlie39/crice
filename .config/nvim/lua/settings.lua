
local cmd = vim.cmd
local indent, width = 4, 80

vim.bo.expandtab=true               -- Use spaces instead of tabs
vim.bo.formatoptions='crqnj'        -- Automatic formatting options'
vim.bo.smartindent=true		    -- Insert indents automatically
vim.bo.shiftwidth=indent            -- Size of an indent
vim.bo.tabstop=indent		    -- Number of spaces tabs count for
vim.bo.textwidth=width		    -- Maximum width of text

vim.wo.colorcolumn=tostring(width)  -- Line length marker
vim.wo.foldmethod='expr'
vim.wo.foldexpr='nvim_treesitter#foldexpr()'
vim.wo.list=true                    -- Show some invisible characters
vim.wo.number=true
vim.wo.relativenumber=true
vim.wo.signcolumn='yes'
vim.wo.wrap=false                   --Disable line wrap
vim.opt.listchars:append('eol:⏎')
-- vim.o.bg='dark'
vim.o.bg='light'
vim.o.foldenable = false
vim.o.clipboard='unnamedplus'
vim.o.cmdheight=2
vim.o.completeopt='menu,noinsert,noselect'  -- Completion options
vim.o.cursorline=true		    -- Highlight cursor line
vim.o.grepprg='rg --vimgrep -n --no-heading --smart-case'
vim.o.hidden=true		    -- Enable background buffers
vim.o.ignorecase=true		    -- Ignore case
vim.o.joinspaces=false		    -- No double spaces with join
vim.o.mouse='nv'
vim.o.pastetoggle='<F5>'	    -- Paste mode
vim.o.ruler=true      -- Command-line completion mode
vim.o.scrolloff=4		    -- Lines of context
vim.o.sidescrolloff=8		    -- Columns of context
vim.o.shiftround=true		    -- Round indent
vim.o.smartindent=true
vim.o.smartcase=true		    -- Dont ignore case with capitals
vim.o.splitbelow=true		    -- Put new windows below current
vim.o.splitright=true		    -- Put new windows right of current
vim.o.swapfile=false
vim.o.termguicolors=true	    -- True color support
vim.o.timeoutlen=500
vim.o.undofile=true
vim.o.updatetime=200		    -- Delay before swap file is saved
vim.o.wildcharm='<Tab>'		    -- Command-line completion mode
vim.o.wildmenu=true		    -- Command-line completion mode
vim.o.wildmode='longest,full'	    -- Command-line completion mode
vim.o.wildoptions='pum'		    -- Command-line completion mode

-- cmd 'syntax enable'
cmd 'filetype plugin indent on'

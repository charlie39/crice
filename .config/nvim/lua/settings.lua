local opt = require('utils').opt

local cmd = vim.cmd
local indent, width = 4, 80

opt('w', 'number', true)
opt('w', 'relativenumber', true)          -- Relative line numbers
opt('w', 'signcolumn', 'yes')             -- Show sign column
opt('w', 'mouse', 'a')                    -- Mouse Support
opt('b', 'smartindent', true)             -- Insert indents automatically
opt('b', 'tabstop', indent)               -- Number of spaces tabs count for
opt('b', 'textwidth', width)              -- Maximum width of text
opt('o', 'completeopt', 'menuone,noselect')  -- Completion options
opt('o', 'hidden', true)                  -- Enable background buffers
opt('o', 'ignorecase', true)              -- Ignore case
opt('o', 'joinspaces', false)             -- No double spaces with join
opt('o', 'pastetoggle', '<F2>')           -- Paste mode
opt('o', 'scrolloff', 4 )                 -- Lines of context
opt('o', 'shiftround', true)              -- Round indent
opt('o', 'sidescrolloff', 8 )             -- Columns of context
opt('o', 'smartcase', true)               -- Dont ignore case with capitals
opt('o', 'splitbelow', true)              -- Put new windows below current
opt('o', 'splitright', true)              -- Put new windows right of current
opt('o', 'termguicolors', true)           -- True color support
opt('o', 'updatetime', 200)               -- Delay before swap file is saved
opt('o', 'wildmenu', true)       		  -- Command-line completion mode
opt('o', 'wildmode', 'longest,full')      -- Command-line completion mode
opt('o', 'wildoptions', 'pum')      	  -- Command-line completion mode
opt('o', 'cursorline', true)              -- Highlight cursor line
opt('o', 'grepprg', 'rg --vimgrep -n --no-heading --smart-case', true)
opt('o', 'cmdheight', 2)
opt('w', 'shiftwidth', indent)            -- Size of an indent
opt('w', 'list', true)                    -- Show some invisible characters
-- opt('o', 'undodir', '~/.cache/nvim/undodir')
opt('o', 'undofile', true)
-- opt('w', 'wrap', false)                   -- Disable line wrap
opt('w', 'wrap', true)                   -- Disable line wrap
opt('w', 'timeoutlen', 500)
opt('o', 'swapfile', false)
opt('o', 'bg', 'light')
opt('o', 'ruler', true)      -- Command-line completion mode
opt('b', 'expandtab', true)               -- Use spaces instead of tabs
opt('b', 'formatoptions', 'crqnj')        -- Automatic formatting options
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options
opt('w', 'colorcolumn', tostring(width))  -- Line length marker
opt('o', 'clipboard', 'unnamedplus')

cmd 'syntax enable'
cmd 'filetype plugin indent on'

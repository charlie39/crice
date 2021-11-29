local utils = require('utils')
local map = utils.map



map('n', '<leader>s', '<cmd>luafile $MYVIMRC<CR>')

--tab traversal
map('n', 'tt', ' <cmd>tabnew<CR>')
map('n', 'TT', '<cmd>tabclose<CR>')
map('n', 'GT ',' <cmd>-tabnext<CR>')
map('n', '<M-1>', '<cmd>1tabnext<CR>')
map('n', '<M-2>', '<cmd>2tabnext<CR>')
map('n', '<M-3>', '<cmd>3tabnext<CR>')
map('n', '<M-4>', '<cmd>4tabnext<CR>')
map('n', '<M-5>', '<cmd>5tabnext<CR>')
map('n', '<M-6>', '<cmd>6tabnext<CR>')
map('n', '<M-7>', '<cmd>7tabnext<CR>')
map('n', '<M-8>', '<cmd>8tabnext<CR>')
map('n', '<M-9>', '<cmd>9tabnext<CR>')
map('n', '<M-$>', '<cmd>$tabnext<CR>')

--Run shell functions

map('n', '<M-w>', ':!zsh -ci wtr 2>/dev/null<CR>')
map('', '<M-p>', ':!zsh -ci pdfr 2>/dev/null<CR>')
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
map('n', '<A-TAB>', '<cmd>bnext<cr>')
	-- " map <Shift><A-TAB> :bprev<cr>
map('n', '<leader>b', '<cmd>ls<cr>:buffer<space>')

-- "window resizing

map('n', '<C-Left>', '<C-W><')
map('n', '<C-Right>', '<C-W>>')
map('n', '<C-Up>', '<C-W>+2')
map('n', '<C-Down>', '<C-W>-2')

map('n', '<S-Left>', '<C-w>2-')
map('n', '<S-Right>', '<C-w>2+')
map('n', '<S-Down>', '<C-w>2<')
map('n', '<S-Up>', '<C-w>2>')

--split window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

--terminal special
map('n', '<leader>t', '<cmd>terminal<CR>')

--ranger
map('n','<M-f>s','<cmd>split | term ranger<cr>')
map('n','<M-f>v','<cmd>vsplit | term ranger<cr>')
map('n','<M-f>t','<cmd>tabe | term ranger<cr>')

--Rnvimr
map('','<M-F>','<cmd>RnvimrToggle<cr>')

--multi-line
-- map('', '<leader>v',[[vim.fn['sml#mode_on']()]])
--FZF
map('n', '<leader>F', '<cmd>Files<CR>')
map('n', '<leader>G', '<cmd>Commits<CR>')
map('n', '<leader>r', '<cmd>Rg<CR>')
map('n', '<leader>b', '<cmd>ls<CR>:buffer<space>')
map('n', '<leader><leader>c', '<cmd>Colors<CR>')

-------------------- MAPPINGS ------------------------------
map('', '<leader>y', '"+y')
map('i', '<C-u>', '<C-g>u<c-u>')
map('i', '<C-w>', '<C-g>u<C-w>')
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('n', '<C-h>', '<cmd>nohlsearch<CR>')
map('n', '<F3>', '<cmd>lua Toggle_wrap()<CR>')
map('n', '<F4>', '<cmd>set spell!<CR>')
map('n', '<F5>', '<cmd>checktime<CR>')
map('n', '<F6>', '<cmd>set scrollbind!<CR>')
map('n', '<leader><Down>', '<cmd>cclose<CR>')
map('n', '<leader><Left>', '<cmd>cprev<CR>')
map('n', '<leader><Right>', '<cmd>cnext<CR>')
map('n', '<leader><Up>', '<cmd>copen<CR>')
map('n','<leader>qb','<cmd>bd!<cr>')
map('n', '<leader>o', 'm`o<Esc>0D``')
map('n', 'S', ':%s//gcI<Left><Left><Left><Left>')
map('v', 'S', ':s//gcI<Left><Left><Left><Left>')
map('n', '<leader>u', '<cmd>update<CR>')
map('n', '<leader>x', '<cmd>conf qa<CR>')
map('t', '<ESC>', '&filetype == "fzf" ? "\\<ESC>" : "\\<C-\\>\\<C-n>"' , {expr = true})
map('t', 'jk', '<ESC>', {noremap = false})
map('n','Q','zq')
map('n','<leader>c', '<cmd>w! <bar> !compiler %<CR>')
map('n', '<leader>p', ':!opout <c-r>%<CR>')
--cool mappings

map('n', 'c', '"_c')

map('n', 'W', '<cmd>w<cr>')
-- map('n', 'X', '<cmd>bp<CR>')

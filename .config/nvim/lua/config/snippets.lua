
--  For  use with Coc
--  Use <M-l> for trigger snippet expand.
local map = require('utils').map

map('n', '<M-l>', 'vim.call[[<Plug>(coc-snippets-expand)]]')

--  Use <M-j> for select text for visual placeholder of snippet.
map('v', '<M-j>', 'vim.call[[<Plug>(coc-snippets-select)]]')

--  Use <M-j> for jump to next placeholder, its default of coc.nvim
vim.g['coc_snippet_next'] = '<c-j>'

--  Use <M-k> for jump to previous placeholder, its default of coc.nvim
vim.g['coc_snippet_prev'] = '<c-k>'

--  Use <M-j> for both expand and jump (make expand higher priority.)
map('n', '<M-j>', 'vim.call[[<Plug>(coc-snippets-expand-jump]])')

--  Use <leader>x for convert visual selected code to snippet
map('x', '<leader>x', 'vim.call[[<Plug>(coc-convert-snippet)]]')

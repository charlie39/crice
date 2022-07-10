 -- press <Tab> to expand or jump in a snippet. These can also be mapped separately
--  via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
--  -1 for jumping backwards.
vim.cmd[[
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
--  For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

--[[ local opts = { noremap = true, silent = true }
vim.keymap.set('i','<expr>',' <Tab>',"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",opts)
vim.keymap.set('s','<Tab>',"<cmd>lua require('luasnip').jump(1)<cr>", opts)
vim.keymap.set('s',"<S-Tab>','<cmd>lua require('luasnip').jump(-1)<cr>",opts)

--  For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.keymap.set('i','<C-E>', luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", opts)
vim.keymap.set('s','<C-E>', luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", opts) ]]


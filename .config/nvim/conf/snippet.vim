" Use <M-l> for trigger snippet expand.
imap <M-l> <Plug>(coc-snippets-expand)

" Use <M-j> for select text for visual placeholder of snippet.
vmap <M-j> <Plug>(coc-snippets-select)

" Use <M-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <M-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <M-j> for both expand and jump (make expand higher priority.)
imap <M-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


"which-key
	  autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
	 nnoremap <silent> <leader>' :<c-u>WhichKey '<Space>'<CR>

" If you wish to hide a mapping from the menu set it's description to 'which_key_ignore'. Useful for instance,
" to hide a list of [1-9] window swapping mappings.
" For example the below mapping will not be shown in the menu.

	" nnoremap <leader>1 :1wincmd w<CR>
	" let g:which_key_map.1 = 'which_key_ignore'
" If you want to hide a group of non-top level mappings, set the name to 'which_key_ignore'. For example,

	" nnoremap <leader>_a :echom '_a'<CR>
	" nnoremap <leader>_b :echom '_b'<CR>
	" let g:which_key_map['_'] = { 'name': 'which_key_ignore' }

" You can configure a Dict for each prefix so that the display is more readable.
" To make the guide pop up Register the description dictionary for the prefix first. Assuming Space is your leader key and the Dict for configuring Space is g:which_key_map:

	" call which_key#register(',', "g:which_key_map")
	vnoremap <silent> <leader>' :<c-u>WhichKeyVisual '<Space>'<CR>

" Define prefix dictionary
let g:which_key_map =  {}

" Second level dictionaries:
" 'name' is a special field. It will define the name of the group, e.g., leader-f is the "+file" group.
" Unnamed groups will show a default empty string.

" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.

	let g:which_key_map.f = { 'name' : '+file' }

	nnoremap <silent> <leader>fs :update<CR>
	let g:which_key_map.f.s = 'save-file'

	nnoremap <silent> <leader>fd :e $MYVIMRC<CR>
	let g:which_key_map.f.d = 'open-vimrc'

	nnoremap <silent> <leader>oq  :copen<CR>
	nnoremap <silent> <leader>ol  :lopen<CR>
	let g:which_key_map.o = {
      \ 'name' : '+open',
      \ 'q' : 'open-quickfix'    ,
      \ 'l' : 'open-locationlist',
      \ }

" =======================================================
" Create menus not based on existing mappings:
" =======================================================
" Provide commands(ex-command, <Plug>/<C-W>/<C-d> mapping, etc.)
" and descriptions for the existing mappings.
"
" Note:
" Some complicated ex-cmd may not work as expected since they'll be
" feed into `feedkeys()`, in which case you have to define a decicated
" Command or function wrapper to make it work with vim-which-key.
" Ref issue #126, #133 etc.

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

let g:which_key_map.l = {
      \ 'name' : '+lsp',
        \ 'd' : ['spacevim#lang#util#Definition()'     , 'definition']      ,
        \ 't' : ['spacevim#lang#util#TypeDefinition()' , 'type-definition'] ,
        \ 'i' : ['spacevim#lang#util#Implementation()' , 'implementation']  ,
      \ }


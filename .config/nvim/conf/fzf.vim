
"select colorscheme for current session
map <leader>k :call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ":t:r")'),'options':'--layout=reverse --preview ""', 'sink': 'colo', 'left': '20%'})<CR>

" nnoremap <leader>. :call fzf#run(fzf#wrap({'source': 'fd  .  ~/{.config,.local/bin,packages/repos,projects/} --type f -H','options': '--bind "ctrl-y:execute-silent(!echo {} | !xclip -sel clip)" -m  --preview "bat --color always {} -n" --preview-window=right:60%:border --color "fg:#bbccdd,fg+:#ddeeff,preview-bg:#000000,border:#332288"'}))<cr>
command! -bang LS call fzf#run(fzf#wrap({'source': 'find  ~/{.config,.local/bin,packages/repos,projects/} -type f','options': '-m  --preview "bat --color always {} -n" --preview-window=right:60%:border --color "fg:#bbccdd,fg+:#ddeeff,preview-bg:#000000,border:#332288"'}, <bang>0))
nnoremap <leader>. <cmd>LS<cr>
nnoremap <leader><leader>. <cmd>LS!<cr>

"text search with rg
command! -bang FZG call fzf#run(fzf#wrap({'source': 'rg --column --line-number --no-heading --color=lways --smart-case "" /home/charlie/projects/ -H','options': '--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --disabled --query "" --height=50% --layout=reverse -m --preview ""'},<bang>0))
command! -bang FZZ call fzf#run(fzf#wrap({'source': 'fd  "" /home/charlie/{.config,.local/bin,packages}','options': '--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --disabled --query "" --height=50% --layout=reverse -m --preview ""'},<bang>0))
nnoremap <leader>zg <cmd>FZG<cr>
nnoremap <leader>zd <cmd>FZG<cr>

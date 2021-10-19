

local keymap = require('utils').map
local exe = vim.api.nvim_exec

exe([[command! -bang LS call fzf#run(fzf#wrap({'source': 'find  ~/{.config,.local/bin,packages/repos,projects/} -type f','options': '-m  --preview "bat --color always {} -n" --preview-window=right:60%:border --color "fg:#bbccdd,fg+:#ddeeff,preview-bg:#000000,border:#332288"'}, <bang>0))]],false)
keymap('n' ,'<leader>.','<cmd>LS<cr>')
keymap('n' ,'<leader><leader>.' ,'<cmd>LS!<cr>')

-- text search with Rg
-- exe([[command! -bang FZG call fzf#run(fzf#wrap({'source': 'rg --column --line-number --no-heading --color=lways --smart-case "" /home/charlie/projects/ -H','options': '--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --disabled --query "" --height=50% --layout=reverse -m --preview ""'},<bang>0))]],false)
-- keymap('n' ,'<leader>zg' ,'<cmd>FZG<cr>')
keymap('n' ,'<leader>zg' ,'<cmd>Rg<cr>')

--file search fd
exe([[command! -bang FZD call fzf#run(fzf#wrap({'source': 'fd  "" /home/charlie/{.config,.local/bin,packages}','options': '--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --disabled --query "" --height=50% --layout=reverse -m --preview ""'},<bang>0))]],false)
keymap('n' ,'<leader>zd' ,'<cmd>FZD<cr>')



--select colorscheme for current session
-- exe([[command!  LSK call fzf#run({'source': keymap(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ':t:r')'),'options':'--layout=reverse --preview ""', 'sink': 'colo', 'left': '20%'})]],false)
exe([[
command! -bang LSK call fzf#run(fzf#wArap({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ':t:r')'),'options':'--layout=reverse --preview ""', 'sink': 'colo', 'left': '20%'},<bang>0))
]],false)
-- keymap <leader>k :call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ":t:r")'),'options':'--layout=reverse --preview ""', 'sink': 'colo', 'left': '20%'})<CR>
keymap('n' ,'<leader>k' ,'<cmd>LSK<cr>')

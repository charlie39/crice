
local keymap = require('utils').map
local exe = vim.api.nvim_exec

vim.g['fzf_action'] = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

exe([[
" search particular directories of interest
command! -bang LS call fzf#run(fzf#wrap({'source': 'find  ~/{.config,.local/bin,packages/repos,projects/} -type f,l','options': '-m  --preview "bat --color always {} -n" --preview-window=right:60%:border --color "fg:#bbccdd,fg+:#ddeeff,preview-bg:#000000,border:#332288"'}, <bang>0))


" Search only nvim directory
command! -bang LSv call fzf#run(fzf#wrap({'source': 'find   ~/{.config/nvim,package/repos/crice/.config} -type f,l','options': '-m  --preview "bat --color always {} -n" --preview-window=right:60%:border --color "fg:#bbccdd,fg+:#ddeeff,preview-bg:#000000,border:#332288"'}, <bang>0))

"file search fd
command! -bang FZD call fzf#run(fzf#wrap({'source': 'fd  "" /home/charlie/{.config,.local/bin,packages} --type f','options': '--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --disabled --query "" --height=50% --layout=reverse -m --preview ""'},<bang>0))
]],false)


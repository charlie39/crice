-- opt = require'utils'.opt

vim.g.laststatus = 0
vim.wo.number = false
vim.wo.relativenumber = false
vim.g.ruler = false
vim.g.showcmd = false

vim.g.firenvim_config = {
  globalSettings = {
    ignoreKeys = {
      all = { '<C-->' },
      normal = { '<C-1>', '<C-2>' }
    },
    alt = "all",
  },
  localSettings = {
    [".*"] = {
      cmdline = "firenvim",
      -- content = "text",
      priority = 0,
      selector = "textarea",
      takeover = "always"
    }
    --[[ ["https?://[^/]+.twitter.com/"] = {
    takeover = "never",
    priority 1print(vim.inspect(vim.api.nvim_get_keymap('n')))
        } ]]
  }
}
-- local fc = vim.g.firenvim_config["localSettings"]
-- fc[ [[https?://[^/]+\.co\.uk/']] ] = { takeover = "never", priority = 1 }
-- local fc[".stackoverflow.com/.*"] = { takeover = "never", priority = 2 }

--[[ let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }

    let fc = vim.g.firenvim_config['localSettings']
    let fc['https?://[^/]+\.twitter.com/'] = { 'takeover' : 'never', 'priority' : 1 }

 ]]

-- local fire = vim.api.nvim_create_augroup('firenvim_autocmd', { clear = true })

--[[ vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'github.com_*.txt',
  command = 'setlocal filetype=markdown',
  desc = 'setlocal github*.txt to markdown',
  group = fire,
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.txt',
  command = 'setlocal filetype=markdown,pandoc',
  desc = 'setlocal *.txt to markdown,pandoc',
  group = fire,
}) ]]

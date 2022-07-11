if vim.fn.empty(vim.g['started_by_firenvim']) == 1 then
    vim.cmd 'packadd galaxyline'
else
    vim.g.laststatus = false
    vim.wo.number = false
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
                content = "text",
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

    vim.api.nvim_exec([[
    augroup firenvim
        autocmd!
        autocmd BufEnter github.com_*.txt set filetype=markdown
        autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
    augroup END]], false)
end

function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        " return luaeval("require('lsp-status').status()")
        return luaeval("require('statusline').status()")
    endif
    return ''
endfunction
set statusline=%{LspStatus()}
set statusline+=%\<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

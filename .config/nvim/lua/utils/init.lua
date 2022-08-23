local utils = {}
local scopes = { o = vim.o, b = vim.bo, w = vim.w }
local cmd, fn, g, exe  =  vim.cmd, vim.fn, vim.g, vim.api.nvim_command

function utils.opt(scope, key, value )
	scopes[scope][key] = value
	if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts )
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

function utils.buf_map(bfnr,mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(bfnr,mode,lhs,rhs, options)
end

function utils.buf_option(bfnr,name,value)
    vim.api.nvim_buf_set_option(bfnr,name, value)
end

return utils

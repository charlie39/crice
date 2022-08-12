-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
--  via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
--  -1 for jumping backwards.
local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets("all", {
  s("hel", {
    t("hello")
  })
})


ls.add_snippets(nil, {
  all = {
    s({
      trig = "date",
      name = "Date",
      dscr = "Datee in the form YYYY-MM-DD",
    }, {
      f(function() return os.date('%d-%m-%Y') end, {}),
    }),
  },
})


-- ls.snippets = require("luasnip_snippets").load_snippets()
require'luasnip.loaders.from_lua'.load({paths = './snippets'})

vim.api.nvim_create_user_command('Snip',function()
  vim.cmd[[source ~/.config/nvim/lua/config/luasnip.lua]]
  vim.notify("luasnip is sourced")
end
,{})

local fun = function()
  if require"luasnip".expand_or_jumpable() then
    require"luasnip".expand_or_jump()
  end
end

local opts = { noremap = true, silent = true }
-- for jumping to parameters in insert node
vim.keymap.set('n','<leader><leader>s','<cmd>Snip<cr>',opts)
vim.keymap.set({'i','s'}, '<C-j>',fun, opts)
vim.keymap.set({'i','s'}, '<C-k>',function() if require"luasnip".expand_or_jumpable() then require"luasnip".expand_or_jump() end end, opts)
vim.keymap.set({'i','s'}, '<C-k>', '<cmd>lua require"luasnip".jump(-1)<cr>', opts)

--  For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- set keybinds for both INSERT and VISUAL.
vim.keymap.set({'i','s'}, "<C-n>", "<Plug>luasnip-next-choice", opts)
vim.keymap.set({'i','s'}, "<C-p>", "<Plug>luasnip-prev-choice", opts)


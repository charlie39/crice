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

local date = function() return { os.date('%d-%m-%Y') } end
ls.add_snippets("all", {
  s("hel", {
    t("hello")
  })
})

ls.add_snippets(nil, {
  all = {
    s({
      trig = "date",
      namr = "Date",
      dscr = "Datee in the form YYYY-MM-DD",
    }, {
      f(date, {}),
    }),
  },
  java = {
    s({
      trig = "func",
      namr = "Func",
      dscr = "generate function"
    }, {
      c(1, {
        t("public"),
        t("private"),
        t("protected"),
        t("void"),
      }),
      i(2, 'function def'),
      t({'', '}'}),
      i(0)
    })
  },
  lua = {
    s({
      trig = 'func',
      namr = 'Func',
      dscr = 'function functionName()'
    }, {
      t("function "), i(1, "function name"), t("("),
      i(2, "args"), t({ ")",""}),
      i(3,"function body"),
      t({ "", "end"}),
    })
  }
})


local opts = { noremap = true, silent = true }
-- for jumping to parameters in insert node
vim.keymap.set('s', '<C-j>', "<cmd>lua require('luasnip').jump(1)<cr>", opts)
vim.keymap.set('i', '<C-j>', "<cmd>lua require('luasnip').jump(1)<cr>", opts)
vim.keymap.set('s', '<C-k>', "<cmd>lua require('luasnip').jump(-1)<cr>", opts)
vim.keymap.set('i', '<C-k>', "<cmd>lua require('luasnip').jump(-1)<cr>", opts)

--  For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.keymap.set('i', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", opts)
vim.keymap.set('s', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", opts)
-- vim.keymap.set('i','<expr>',' <Tab>',"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",opts)

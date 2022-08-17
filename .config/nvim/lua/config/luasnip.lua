-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
--  via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
--  -1 for jumping backwards.
local ls = require('luasnip')
local types = require 'luasnip.util.types'

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require 'luasnip.extras.fmt'.fmt


ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  --[[ ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      }
    }
  } ]]
}

local function simple_restore(args, _)
  return sn(nil, { t(args[1]) })
end

ls.add_snippets("html", {
  s("html", {
    t('<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">')
  }),
  s({
    trig = 'tag',
    name = 'Tag',
    dscr = '<tag>[..]</tag> Dynamic Matching Closing Tag'
  }, {
    t('<'), i(1, 'tag name'), t('>'), i(2), t('</'), d(3, simple_restore, 1), t({ ">", "" })
  }),
  s({
    trig = 'label',
    name = 'Label',
    dscr = 'Label template',
  }, {
    t('<label'),
    c(1, {
      t('>'),
      sn(nil, { t(' for="'),i(1),t('">')})
    }),
    i(2),
    t('</label>')
  }),
  s({ trig = 'li', name = 'List', dscr = 'List item' }, {
    t('<li'),
    c(1, {
      t(' '),
      sn(nil, { t('th:each="'), t(':'), t('${'), i(1), t('}">') }),
    }),
    t('>'),
    i(2),
    t('</li>')
  })
})

ls.add_snippets("all", {
  s("example2", fmt([[
    if {} then
      {}
    end
    ]], {
    -- i(1) is at nodes[1], i(2) at nodes[2].
    i(1, "not now"), i(2, "when")
  }))
})
local insert_file = function()
  return vim.fn.fnamemodify(vim.fn.expand('%'), ':p')
end


ls.add_snippets("lua", {
  s({ trig = "file", dscr = "return current filename" }, {
    f(insert_file, {})
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
require 'luasnip.loaders.from_lua'.load({ paths = './snippets' })

vim.api.nvim_create_user_command('Snip', function()
  vim.cmd [[source ~/.config/nvim/lua/config/luasnip.lua]]
  vim.notify("luasnip is sourced")
end
  , {})

local fun = function()
  if require "luasnip".expand_or_jumpable() then
    require "luasnip".expand_or_jump()
  end
end

local opts = { noremap = true, silent = true }
-- for jumping to parameters in insert node
vim.keymap.set('n', '<leader><leader>s', '<cmd>Snip<cr>', opts)
vim.keymap.set({ 'i', 's' }, '<C-j>', fun, opts)
vim.keymap.set({ 'i', 's' }, '<C-k>',
  function() if require "luasnip".expand_or_jumpable() then require "luasnip".expand_or_jump() end end, opts)
vim.keymap.set({ 'i', 's' }, '<C-k>', '<cmd>lua require"luasnip".jump(-1)<cr>', opts)


--  For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- set keybinds for both INSERT and VISUAL.
opts = { silent = true, expr = true, remap = true }

-- vim.keymap.set({ 'i', 's' }, "<C-n>", "<Plug>luasnip-next-choice", { remap = true })
vim.keymap.set({ 'i', 's' }, "<C-n>", '<cmd>lua require"luasnip.extras.select_choice"()<cr>', { remap = true })
vim.keymap.set({ 'i', 's' }, "<C-p>", "<Plug>luasnip-prev-choice", { remap = true })

--[[ vim.keymap.set({'i','s'}, "<C-n>", function() return require'luasnip'.choice_active() and "<Plug>luasnip-next-choice" or '<C-n>' end, opts)
vim.keymap.set({'i','s'}, "<C-p>", function() return require'luasnip'.choice_active() and "<Plug>luasnip-prev-choice" or '<C-p>' end, opts) ]]

--[[ vim.keymap.set({'i','s'}, '<C-p>',function() if require'luasnip'.choice_active() then return '<Plug>luasnip-prev-choice' else return '<C-p>' end end,opts)
vim.keymap.set({'i','s'}, '<C-n>',function() if require'luasnip'.choice_active() then  return '<Plug>luasnip-next-choice' else return '<cmd>vim.notify("not")<cr>' end end,{silent = true, expr = true,remap =true}) ]]

--default mappings
local map = require('utils').map
local opts = { noremap = true, silent = true }
map('', '<leader>f', '<cmd>Telescope<cr>', opts)
map('', '<leader>fc', '<cmd>Telescope colorscheme<cr>', opts)
map('', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

map('', '<leader>fgc', '<cmd>Telescope git_commits<cr>', opts)
map('', '<leader>fgf', '<cmd>Telescope git_files<cr>', opts)
map('', '<leader>fgb', '<cmd>Telescope git_branches<cr>', opts)

map('', '<leader>fM', '<cmd>Telescope man_pages<cr>', opts)
map('', '<leader>fq', '<cmd>Telescope quickfix<cr>', opts)
map('', '<leader>fk', '<cmd>Telescope keymaps<cr>', opts)
map('', '<leader>fr', '<cmd>Telescope registers<cr>', opts)
map('', '<leader>fR', '<cmd>Telescope reloader<cr>', opts)



-- Using lua functions
local actions = require('telescope.actions')
local telescope = require("telescope")
telescope.setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = 'TS>',
    color_devicons = true,
    scroll_strategy = 'cycle',

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        -- ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist
      },
    }
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true
    },
    -- This is your opts table
    ["ui-select"] = {
      require("telescope.themes").get_cursor {
        -- even more opts
      },

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      -- codeactions = false,
      -- }
    }
  }
}

--trouble
local t_ok, trouble = pcall(require, "trouble.providers.telescope")
if t_ok then
  telescope.setup {
    defaults = {
      mappings = {
      },
    },
  }

end

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

pcall(require('telescope').load_extension, 'fzf')
pcall(require("telescope").load_extension("ui-select"))

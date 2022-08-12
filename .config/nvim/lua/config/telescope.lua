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
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    -- This is your opts table
    ["ui-select"] = {
      require("telescope.themes").get_cursor {
        prompt_prefix = "~>>"
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
--[[ local t_ok, trouble = pcall(require, "trouble.providers.telescope")
if t_ok then
  telescope.setup {
    defaults = {
      mappings = {
      },
    },
  }

end ]]

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

pcall(require('telescope').load_extension, 'fzf')
pcall(require("telescope").load_extension("ui-select"))

--default mappings
local map = require('utils').map
local opts = { noremap = true, silent = true }
local xdg_conf = os.getenv('XDG_CONFIG_HOME')

map('', '<leader>f' , ':lua require"telescope.builtin".builtin()<cr>', opts)
map('', '<leader>ff' , ':lua require"telescope.builtin".find_files()<cr>', opts)
map('', '<leader>fc', ':lua require"telescope.builtin".colorscheme()<cr>', opts)
map('', '<leader>fgg', ':lua require"telescope.builtin".live_grep()<cr>', opts)
map('', '<leader>fss', ':lua require"telescope.builtin".grep_string({ word_match = "-w" })<cr>', opts)
map('', '<leader>fvs', ':lua require"telescope.builtin".grep_string({ word_match = "-w", cwd = "~/.config/nvim" })<cr>', opts)
map('', '<leader>fb', ':lua require"telescope.builtin".buffers()<cr>', opts)
map('', '<leader>fh', ':lua require"telescope.builtin".help_tags()<cr>', opts)

map('', '<leader>fgc', ':lua require"telescope.builtin".git_commits()<cr>', opts)
map('', '<leader>fgf', ':lua require"telescope.builtin".git_files()<cr>', opts)
map('', '<leader>fgb', ':lua require"telescope.builtin".git_branches()<cr>', opts)

map('', '<leader>fM', ':lua require"telescope.builtin".man_pages()<cr>', opts)
map('', '<leader>fq', ':lua require"telescope.builtin".quickfix()<cr>', opts)
map('', '<leader>fl', ':lua require"telescope.builtin".loclist()<cr>', opts)
map('', '<leader>fk', ':lua require"telescope.builtin".keymaps()<cr>', opts)
map('', '<leader>fo', ':lua require"telescope.builtin".vim_options()<cr>', opts)
map('', '<leader>fr', ':lua require"telescope.builtin".registers()<cr>', opts)
map('', '<leader>fR', ':lua require"telescope.builtin".reloader()<cr>', opts)
map('','<leader>fm', ':lua require"telescope.builtin".marks()<cr>',opts)
map('','<leader>fj', ':lua require"telescope.builtin".jumplist()<cr>',opts)

---custom
map('', '<leader>m',':lua require"config.finders".nvim_conf()<cr>', opts)
map('', '<leader><leader>m',':lua require"config.finders".nvim_conf({ layout_config = { height = 0.99, width = 0.99 }})<cr>', opts)
map('', '<leader>.', ':lua require"config.finders".generic_special()<cr>', opts)
map('', '<leader><leader>.',':lua require"config.finders".generic_special({ layout_config = { height = 0.99, width = 0.99 }})<cr>', opts)
map('', '<leader>fgv',':lua require"config.finders".my_live_grep({ search_dirs = { "~/.config/nvim/" }, prompt_title = "Live Grep (nvim)" })<cr>',opts)
map('', '<leader>fgl',':lua require"config.finders".my_live_grep()<cr>',opts)

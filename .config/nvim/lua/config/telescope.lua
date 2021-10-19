	--default mappings
    local map = require('utils').map
		local opts = { noremap=true, silent=true }
		map('','<leader>f', '<cmd>Telescope<cr>', opts)
		map('','<leader>ff', '<cmd>Telescope find_files<cr>', opts)
		map('','<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
		map('','<leader>fb', '<cmd>Telescope buffers<cr>', opts)
		map('','<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

		map('','<leader>fgc', '<cmd>Telescope git_commits<cr>', opts)
		map('','<leader>fgf', '<cmd>Telescope git_files<cr>', opts)
		map('','<leader>fgb', '<cmd>Telescope git_branches<cr>', opts)

		map('','<leader>fm', '<cmd>Telescope man_pages<cr>', opts)
		map('','<leader>fq', '<cmd>Telescope quickfix<cr>', opts)


	-- Using lua functions
		local actions = require('telescope.actions')
		require('telescope').setup {
			defaults = {
				file_sorter =  require('telescope.sorters').get_fzy_sorter,
				prompt_prefix = 'TS>',
				color_devicons =  true,
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
				fzy_native = {
					override_generic_sorter = true,
					override_file_sorter = true
				},
			}
		}
		require('telescope').load_extension('fzy_native')

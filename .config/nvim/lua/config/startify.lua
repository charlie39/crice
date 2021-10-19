
 -- Most used options:
     --[[ let g:startify_bookmarks= systemlist("cut -sd' ' -f 2- ~/.local/share/nvim/NERDTreeBookmarks")
     let g:startify_change_to_dir="~/"
     let g:startify_change_to_vcs_root=1
     let g:startify_change_cmd=1
     let g:startify_custom_header=1
     let g:startify_enable_special=1
     let g:startify_list_order=1
     let g:startify_lists=1
     let g:startify_skiplist=1
     let g:startify_update_oldfiles=1 ]]

 -- Misc options:
     vim.g['startify_commands'] =  {
         {S = {'Startify ref', 'h startify'}},
         {'Vim Reference', 'h ref'},
         ':help reference',
         }
     --[[ let g:startify_custom_footer=1
     let g:startify_custom_header_quotes=1
     let g:startify_custom_indices=1
     let g:startify_disable_at_vimenter=1
     let g:startify_enable_unsafe=1
     let g:startify_files_number=1
     let g:startify_fortune_use_unicode=1
     let g:startify_padding_left=1
     let g:startify_relative_path=1
     let g:startify_skiplist_server=1
     let g:startify_use_env=1 ]]

	vim.cmd[[hihighlight StartifyBracket ctermfg=240]]
    vim.cmd[[hihighlight StartifyFooter  ctermfg=240]]
    vim.cmd[[hihighlight StartifyHeader  ctermfg=114]]
    vim.cmd[[hihighlight StartifyNumber  ctermfg=215]]
    vim.cmd[[hihighlight StartifyPath    ctermfg=245]]
    vim.cmd[[hihighlight StartifySlash   ctermfg=240]]
    vim.cmd[[hihighlight StartifySpecial ctermfg=240]]
 --[[ Sessions:~
     let g:startify_session_before_save=1
     let g:startify_session_delete_buffers=1
     let g:startify_session_number=1
     let g:startify_session_persistence=1
     let g:startify_session_remove_lines=1
     let g:startify_session_savecmds=1
     let g:startify_session_savevars=1
     let g:startify_session_sort=1 ]]
    vim.g['startify_session_autoload']=1

 -- Read ~/.NERDTreeBookmarks file and takes its second column
--[[ local function getbookmarks()
    local bookmarks = systemlist("cut -d' ' -f 2- ~/.config/files")
    bookmarks = bookmarks[0:-2] -- Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
end ]]

--[[ function! s:commonfiles()
	let cfiles = systemlist("find  ~/packages/ -type f -regextype egrep -regex '.*config.h'")
	let cfiles =cfiles[0:-2]
	return map(cfiles,"{'line': v:val, 'path': v:val}")
endfunction

function! s:vimUserConf()
	let vmconf = systemlist("find ~/.config/nvim/conf -type f")
	return map(vmconf,"{'line': v:val, 'path': v:val}")
end]]

--[[ vim.g['startify_lists'] = {
           {
               'type'= 'dir',
               'header'= {
                   '  MRU '. getcwd()
               }
           },
         {
             'type'= { function(getbookmarks), 'header'= { '   Bookmarks'}},
           { 'type'= 'sessions',  'header': ['   Sessions']       },
		   { 'type'= function('s:vimUserConf'), 'header': [' 	 NVim User Conf']  },
           { 'type'= function('s:commonfiles'),  'header': ['   DWM,Blocks and st Configs']       },
           { 'type'= 'commands',  'header': ['   Commands']       }
          }

 -- function! StartifyEntryFormat()
        --  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
     -- endfunction ]]

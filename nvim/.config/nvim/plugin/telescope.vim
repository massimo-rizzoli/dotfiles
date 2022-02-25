" ps project search
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>

nnoremap <leader>fm <cmd>Telescope man_pages<cr>

nnoremap <leader>fcf <cmd>Telescope current_buffer_fuzzy_find<cr>

" Open nvim config files
nnoremap <leader>vrc <cmd>lua require('mylua.telescope').search_nvimdotfiles()<cr>

" Open xmonad config files
nnoremap <leader>xm <cmd>lua require('mylua.telescope').search_xmonaddotfiles({hidden=1,})<cr>

" Open file browser
"nnoremap <leader>. <cmd>lua require('telescope.builtin').file_browser({hidden=1,})<cr>
nnoremap <leader>. <cmd>lua require 'telescope'.extensions.file_browser.file_browser({hidden=1,})<cr>

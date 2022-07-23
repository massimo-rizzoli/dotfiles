" ps project search
"nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>ff <Cmd>Telescope find_files<CR>
nnoremap <Leader>fg <Cmd>Telescope live_grep<CR>
nnoremap <Leader>fb <Cmd>Telescope buffers<CR>
nnoremap <Leader>fh <Cmd>Telescope help_tags<CR>
nnoremap <Leader>fr <Cmd>Telescope oldfiles<CR>
nnoremap <Leader>gb <Cmd>Telescope git_branches<CR>

nnoremap <Leader>fm <Cmd>Telescope man_pages<CR>

nnoremap <Leader>fcf <Cmd>Telescope current_buffer_fuzzy_find<CR>

" Open nvim config files
nnoremap <Leader>vrc <Cmd>lua require('mylua.telescope').search_nvimdotfiles()<CR>

" Open xmonad config files
nnoremap <Leader>xm <Cmd>lua require('mylua.telescope').search_xmonaddotfiles({hidden=1,})<CR>

" Open file browser
"nnoremap <Leader>. <Cmd>lua require('telescope.builtin').file_browser({hidden=1,})<CR>
nnoremap <Leader>. <Cmd>lua require 'telescope'.extensions.file_browser.file_browser({hidden=1,})<CR>

" Open project browser
nnoremap <Leader>fp <Cmd>lua require'telescope'.extensions.project.project({hidden_files=true})<CR>

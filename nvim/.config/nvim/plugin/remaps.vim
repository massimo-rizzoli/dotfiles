"" Remaps
" mode lhs rhs
" n normal mode, nore no recursive remapping, map map

" Make Y behave as other vim capital letters
nnoremap Y y$

" Keep cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" Break undo sequence in insert mode
inoremap . .<C-g>u
inoremap , ,<C-g>u
inoremap / /<C-g>u
inoremap <Enter> <Enter><C-g>u
inoremap <Space> <Space><C-g>u

" Jumplist
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap <silent> <M-j> :m '>+1<CR>gv=gv
vnoremap <silent> <M-k> :m '<-2<CR>gv=gv
inoremap <silent> <M-j> <Esc>:m .+1<CR>==a
inoremap <silent> <M-k> <Esc>:m .-2<CR>==a
nnoremap <silent> <M-j> :m .+1<CR>==
nnoremap <silent> <M-k> :m .-2<CR>==
"horizontal movement
vnoremap <silent> <M-l> dpgvlol
vnoremap <silent> <M-h> dhhpgvhoh

" Registers remaps
" send deletion to void, keep copied text
vnoremap p "_dP

" Set working directory ad the containing folder of the opened file
nnoremap <Leader>cd <Cmd>cd %:p:h \| pwd<CR>
" Set working directory to the home directory
nnoremap <Leader>hcd <Cmd>cd $HOME \| pwd<CR>

" Reselect after indenting
vnoremap > >gv
vnoremap < <Gv

" Latex open preview
nnoremap <Leader>lp <Cmd>silent !latexmk -silent -pv -pdf -synctex=1 -interaction=nonstopmode -file-line-error<CR>
" Latex open preview verbose
nnoremap <Leader>lv <Cmd>!latexmk -silent -pv -pdf -synctex=1 -interaction=nonstopmode -file-line-error<CR>
" Latex create .latexmkrc
nnoremap <Leader>lrc <Cmd>silent !cp $HOME/Templates/.latexmkrc ./.latexmkrc<CR>

" Search & Replace shortcuts
noremap ;; :s:::g<Left><Left><Left>
noremap ;: :%s:::g<Left><Left><Left>

" Open main.pdf
"nnoremap <Leader>lo <Cmd>silent !evince main.pdf &<CR>
nnoremap <Leader>lo <Cmd>silent !evince README.pdf &<CR>

" Python run current file
nnoremap <Leader>pr <Cmd>!python %<CR>
nnoremap <Leader>pd oimport pdb; pdb.set_trace()<Esc>_

" Retab
nnoremap <Leader>rr <Cmd>set list noet<CR>:%retab!  \| set ts=2<C-Left><C-Left><C-Left><C-Left>
" Toggle list
nnoremap <Leader>rl <Cmd>set invlist<CR>
nnoremap <Leader>ru :set ts= et \| retab \| set ts=2<C-Left><C-Left><C-Left><C-Left><C-Left><C-Left><Left>
nnoremap <Leader>rs <Cmd>verbose set et? ts? sts? sw?<CR>

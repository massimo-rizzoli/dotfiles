call plug#begin('$HOME/.vim/plugged')

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'gruvbox-community/gruvbox'

" Language server configurations
Plug 'neovim/nvim-lspconfig'

" Undotree
Plug 'mbbill/undotree'

" Autocomplete
"Plug 'hrsh7th/nvim-compe'
" youcompleteme?
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
Plug 'hrsh7th/nvim-cmp/', { 'branch': 'main'}
Plug 'hrsh7th/cmp-path', { 'branch': 'main'}
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Orgmode for nvim (at least I can see the agenda with it)
Plug 'nvim-orgmode/orgmode'
" Plug 'powentan/vim-orgmode'
" org bulletpoints
Plug 'akinsho/org-bullets.nvim', { 'branch': 'main'}

" nvim-colorizer
Plug 'norcalli/nvim-colorizer.lua'

" Lightline bar
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
"return luaeval('vim.diagnostic.get(' . bufnr() . ', [[' . a:level . ']])') || 0
" lsp status for lightline
Plug 'josa42/nvim-lightline-lsp'
"Plug 'massimo-rizzoli/nvim-lightline-lsp'

" vim virtualenv (requires pynvim: see help provider-python)
""Plug 'jmcantrell/vim-virtualenv'
Plug 'nvim-lua/completion-nvim'
"Plug 'HallerPatrick/py_lsp.nvim', { 'branch': 'main' }
Plug 'lambdalisue/vim-pyenv'

" Smart commenting
Plug 'preservim/nerdcommenter'

" Autopairs
Plug 'windwp/nvim-autopairs'

" VimBeGood game
"Plug 'ThePrimeagen/vim-be-good'

" Git
Plug 'tpope/vim-fugitive'
" commit browser
Plug 'junegunn/gv.vim'
" git signs
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main'}

" AirLatex - overleaf (requires: keyring tornado requests pynvim)"
"Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
Plug 'massimo-rizzoli/AirLatex.vim', {'do': ':UpdateRemotePlugins'}

" Dashboard
"Plug 'glepnir/dashboard-nvim'
Plug'goolord/alpha-nvim', { 'branch': 'main'}

" ReStructuredText previewer
"Plug 'Rykka/InstantRst'

call plug#end()

colorscheme gruvbox
" Transparent background
"highlight Normal guibg=none


set termguicolors

"" Require configurations
lua require('mylua')



"" Remaps
" use space as leader
let mapleader = ' '
" mode lhs rhs
" n normal mode, nore no recursive remapping, map map

" Y behave as other vim capital letters
nnoremap Y y$

" Keep cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" Break undo sequence in insert mode
inoremap . .<C-g>u
inoremap , ,<C-g>u
inoremap / /<C-g>u
inoremap <enter> <enter><c-g>u
inoremap <space> <space><c-g>u

" Jumplist
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap <silent> <M-j> :m '>+1<cr>gv=gv
vnoremap <silent> <M-k> :m '<-2<cr>gv=gv
inoremap <silent> <M-j> <esc>:m .+1<cr>==a
inoremap <silent> <M-k> <esc>:m .-2<cr>==a
nnoremap <silent> <M-j> :m .+1<cr>==
nnoremap <silent> <M-k> :m .-2<cr>==
"horizontal movement
vnoremap <silent> <M-l> dpgvlol
vnoremap <silent> <M-h> dhhpgvhoh

" Registers remaps
" send deletion to void, keep copied text
vnoremap p "_dP

" Set working directory ad the containing folder of the opened file
nnoremap <leader>cd <cmd>cd %:p:h \| pwd<cr>
" Set working directory to the home directory
nnoremap <leader>hcd <cmd>cd $HOME \| pwd<cr>

" Reselect after indenting
vnoremap > >gv
vnoremap < <gv

" Latex open preview
nnoremap <leader>lp <cmd>silent !latexmk -silent -pv -pdf -synctex=1 -interaction=nonstopmode -file-line-error<cr>
" Latex open preview verbose
nnoremap <leader>lv <cmd>!latexmk -silent -pv -pdf -synctex=1 -interaction=nonstopmode -file-line-error<cr>
" Latex create .latexmkrc
nnoremap <leader>lrc <cmd>silent !cp $HOME/Templates/.latexmkrc ./.latexmkrc<cr>

" Search & Replace shortcuts
noremap ;; :s:::g<Left><Left><Left>
noremap ;: :%s:::g<Left><Left><Left>
" confirm each substitution
"noremap ;' :%s:::cg<Left><Left><Left><Left>

" Open main.pdf
"nnoremap <leader>lo <cmd>silent !evince main.pdf &<cr>
nnoremap <leader>lo <cmd>silent !evince README.pdf &<cr>

" Python run current file
nnoremap <leader>pr <cmd>!python %<cr>



" Treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF

""lua << EOF
""require'py_lsp'.setup {
""  host_python = "/usr/bin/python3"
""}
""EOF



" Autopairs setup
lua require('nvim-autopairs').setup{}



fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
" Autocommands
augroup MY_GROUP

  " Reset only my autocmds when shout out (so %)
  " (avoid having a listener for each call of of so %)
  autocmd!

  " before writing a buffer, for all file types, call TrimWhiteSpace()
  autocmd BufWritePre * :call TrimWhitespace()

  " lsp auto-format
  autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
  " not working
  autocmd BufWritePre *.vim lua vim.lsp.buf.formatting_sync(nil, 100)

  " latex compile on save
  autocmd BufWritePost *.tex,*.bib silent! :execute "!latexmk -silent -pdf -synctex=1 -interaction=nonstopmode -file-line-error"

  " pandoc compile on save
  autocmd BufWritePost main.md silent! :execute "!pandoc main.md --include-in-header=preamble.tex --citeproc --bibliography=bibliography.bib -t beamer -o main.pdf"
  autocmd BufWritePost README.md silent! :execute "!pandoc README.md -o README.pdf"

  " highlight when yank
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank{timeout=100}

augroup END

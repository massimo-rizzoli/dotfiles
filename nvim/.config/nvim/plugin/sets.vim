set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set noswapfile
set nobackup
set undodir=$HOME/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set termguicolors
set completeopt=menuone,noinsert,noselect
" set colorcolumn=80
set signcolumn=yes
set guifont="Hack Nerd Font Mono":h40
" since lightline shows the status, hide --INSERT-- etc.
set noshowmode

" tab/spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"set noexpandtab
set smartindent
" needed because of line 117 of /usr/share/nvim/runtime/ftplugin/python.vim
let g:python_recommended_style=0

" Default tex
let g:tex_flavor = "latex"

" Default python interpreter path
let g:python3_host_prog = '$HOME/.pyenv/versions/py3nvim/bin/python'

" Clipboard (requires xclip)
set clipboard+=unnamedplus

" AirLatex username
"let g:AirLatexUsername='cookies:overleaf_session2=$OVERLEAF'
let g:AirLatexBuftype='NORMAL'
"let g:AirLatexLogLevel="DEBUG"
"let g:AirLatexLogFile='AirLatex.log'

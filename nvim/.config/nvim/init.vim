call plug#begin('$HOME/.vim/plugged')

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-project.nvim'

Plug 'gruvbox-community/gruvbox'

" Language server configurations
Plug 'neovim/nvim-lspconfig'

" Undotree
Plug 'mbbill/undotree'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
Plug 'hrsh7th/nvim-cmp/', { 'branch': 'main'}
Plug 'hrsh7th/cmp-path', { 'branch': 'main'}
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Orgmode for nvim
Plug 'nvim-orgmode/orgmode'
Plug 'dhruvasagar/vim-table-mode'
" Org Bulletpoints
Plug 'akinsho/org-bullets.nvim', { 'branch': 'main'}

" nvim-colorizer
Plug 'norcalli/nvim-colorizer.lua'

" Lightline bar
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
" lsp status for lightline
Plug 'josa42/nvim-lightline-lsp'

" Vim Virtualenv (requires pynvim: see help provider-python)
Plug 'nvim-lua/completion-nvim'
Plug 'lambdalisue/vim-pyenv'

" Smart commenting
Plug 'preservim/nerdcommenter'

" Autopairs
Plug 'windwp/nvim-autopairs'

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
Plug'goolord/alpha-nvim', { 'branch': 'main'}

call plug#end()


colorscheme gruvbox
" Transparent background
"highlight Normal guibg=none


set termguicolors

" use space as leader
let mapleader = ' '


"" Require configurations
lua require('mylua')


" Treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF


" Autopairs setup
lua require('nvim-autopairs').setup{}


fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
" Autocommands
augroup MY_GROUP

  " Reset only my autocmds when sourcing files (so %)
  " (avoid having a listener for each call of so %)
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

  " Set .cff filetype to yaml
  autocmd BufRead,BufNewFile,BufNew *.cff set filetype=yaml

  " xmobar set file type (cannot use spaces in between commas and events)
  autocmd BufRead,BufNewFile,BufNew xmobarrc set filetype=haskell

augroup END

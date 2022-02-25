" lightline gruvbox colorscheme
" let g:lightline = {
"   \'active': {
"     \'left': [[ 'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ] , [ 'lsp_status' ]]
"   \}
" \}

" " register compoments:
" let g:lightline = {}

let g:lightline = {
\   'active': {
\     'left': [ [ 'mode', 'paste', 'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ] ,
\               [ 'lsp_status', 'gitbranch', 'readonly', 'filename', 'modified'] ]
\   },
\   'component_function':{
\     'gitbranch': 'FugitiveHead'
\   },
\}
call lightline#lsp#register()

let g:lightline.colorscheme = 'gruvbox'

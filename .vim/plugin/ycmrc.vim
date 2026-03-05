
" this file configures YouCompleteMe package
" based on User Guide provided here
" https://github.com/ycm-core/YouCompleteMe

" Provide highlighting according to the underlying
" semantic type of the word, rather than classic
" syntax highlighting based on regular expressions
let g:ycm_enable_semantic_highlighting=1

" stop screen from shifting when encounter an error/warning
set signcolumn=number
" make errors and warnings distinguishable
let g:ycm_error_symbol = '!'
let g:ycm_warning_symbol = '?'
" disable verbose highlighting of diagnosed places
let g:ycm_enable_diagnostic_highlighting = 0

" standard Vim LSP navigation bindings (matches LazyVim defaults)
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gD :YcmCompleter GoToDeclaration<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gI :YcmCompleter GoToImplementation<CR>
nnoremap gy :YcmCompleter GoToType<CR>

" disable the popup
let g:ycm_auto_hover = ''

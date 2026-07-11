
" this file configures YouCompleteMe package
" based on User Guide provided here
" https://github.com/ycm-core/YouCompleteMe

" Provide highlighting according to the underlying
" semantic type of the word, rather than classic
" syntax highlighting based on regular expressions
let g:ycm_enable_semantic_highlighting=1

" Let YCM collect identifiers from tags files
" using them as external database for identifiers
" instead of collecting them in memory
" Source: https://github.com/ycm-core/YouCompleteMe/issues/135#issuecomment-13903816
let g:ycm_collect_identifiers_from_tags_files = 1

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
nnoremap gf :YcmCompleter GoToInclude<CR>
nnoremap gI :YcmCompleter GoToImplementation<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gy :YcmCompleter GoToType<CR>

" disable the popup
let g:ycm_auto_hover = ''

augroup ycm_doc
  autocmd!
  autocmd FileType c,cpp,objc,objcpp,python nnoremap <buffer> K :YcmCompleter GetDoc<CR>
augroup END

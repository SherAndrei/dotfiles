
" here we disable builtin plugins by essentially
" telling vim that they are loaded already

" disabling these packages
" 1. decreases startup time
" 2. clears up user defined commands (see :command)

" Vimballs are not commonly used in favour of Vundle, Pathogen, etc.
" Source: https://vi.stackexchange.com/questions/490/why-arent-vimballs-commonly-used
let g:loaded_vimballPlugin = 1
let g:loaded_vimball = 1

" GLVS (GetLatestVimScripts) is not used in favour of Vundle, Pathogen, etc
" see https://vimdoc.sourceforge.net/htmldoc/pi_getscript.html
let g:loaded_getscriptPlugin = 1

" Required for converting syntax highlighted file to HTML.
" Removed as unused.
" Source:
" https://github.com/vim/vim/blob/762a79e15c8549bc78cbf735723644f9c8578139/runtime/plugin/tohtml.vim
let g:loaded_2html_plugin = 1

" Required to do Boolean-logic based regular expression pattern matching
" Removed as unused
" Source:
" https://github.com/vim/vim/blob/762a79e15c8549bc78cbf735723644f9c8578139/runtime/plugin/logiPat.vim
let g:loaded_logipat = 1

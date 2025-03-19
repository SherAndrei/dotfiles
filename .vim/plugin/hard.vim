
if exists('g:hard_loaded')
	finish
endif
let g:hard_loaded = 1

function! Prevent()
	echo 'Denied'
endfun

" unmaps in normal mode
nnoremap <buffer> <Left> <Esc>:call Prevent()<CR>
nnoremap <buffer> <Right> <Esc>:call Prevent()<CR>
nnoremap <buffer> <Up> <Esc>:call Prevent()<CR>
nnoremap <buffer> <Down> <Esc>:call Prevent()<CR>
nnoremap <buffer> <PageUp> <Esc>:call Prevent()<CR>
nnoremap <buffer> <PageDown> <Esc>:call Prevent()<CR>
nnoremap <buffer> <Home> <Esc>:call Prevent()<CR>
nnoremap <buffer> <End> <Esc>:call Prevent()<CR>

" unmaps in insert mode
inoremap <buffer> <Left> <Esc>:call Prevent()<CR>
inoremap <buffer> <Right> <Esc>:call Prevent()<CR>
inoremap <buffer> <Up> <Esc>:call Prevent()<CR>
inoremap <buffer> <Down> <Esc>:call Prevent()<CR>
inoremap <buffer> <PageUp> <Esc>:call Prevent()<CR>
inoremap <buffer> <PageDown> <Esc>:call Prevent()<CR>
inoremap <buffer> <Home> <Esc>:call Prevent()<CR>
inoremap <buffer> <End> <Esc>:call Prevent()<CR>

" unmaps in visual mode
vnoremap <buffer> <Left> <Esc>:call Prevent()<CR>
vnoremap <buffer> <Right> <Esc>:call Prevent()<CR>
vnoremap <buffer> <Up> <Esc>:call Prevent()<CR>
vnoremap <buffer> <Down> <Esc>:call Prevent()<CR>
vnoremap <buffer> <PageUp> <Esc>:call Prevent()<CR>
vnoremap <buffer> <PageDown> <Esc>:call Prevent()<CR>
vnoremap <buffer> <Home> <Esc>:call Prevent()<CR>
vnoremap <buffer> <End> <Esc>:call Prevent()<CR>

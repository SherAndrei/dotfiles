" while searching though a file incrementally
" highlight matching characters as you type.
set incsearch

" ignore capital letters during search.
set ignorecase

" override the ignorecase option if searching for capital letters.
" This allows search specifically for capital letters.
set smartcase

" Use highlighting when doing a search.
set hlsearch
" Clear highlighing in normal mode by pressing Esc
nnoremap <Esc> :nohlsearch<CR>

" Show upper and lower line on match
set scrolloff=2

" Disable searches wrap around the end of file
" to be able to clearly see the last entry
set nowrapscan


" disable compatibility with vi
" set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on

colorscheme desert

" add current line number
set number
" add relative numbers to current line
" to be able to quickly jump between lines with 23j or 32k
set relativenumber
" as numbers are relative there is no need to use default
" amount of numberwidth=4
set numberwidth=3

" cursor crosshair
set cursorline
set cursorcolumn


" enable auto completion menu after pressing TAB.
set wildmenu

" make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


" while searching though a file incrementally
" highlight matching characters as you type.
set incsearch

" ignore capital letters during search.
set ignorecase

" override the ignorecase option if searching for capital letters.
" This allows search specifically for capital letters.
set smartcase

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Show upper and lower line on match
set scrolloff=2


" clear status line when vimrc is reloaded.
set statusline=

" status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" use a divider to separate the left side from the right side.
set statusline+=%=

" status line right side.
set statusline+=\ [%l\/%L]\ :\ %c\ %p%%

" show the status on the second to last line.
set laststatus=2


" copy indent from current line when starting a new line
set autoindent

" number of spaces to use for each step of (auto)indent.
set shiftwidth=2

" do not use the appropriate number of spaces to insert a <Tab>.
set noexpandtab

" number of spaces that a <Tab> in the file counts for.
set tabstop=2

" highlight invisble stuff
set listchars=trail:·,tab:>→,nbsp:%
set list
" highlight whitespaces at the end of lines
highlight ExtraWhitespace ctermbg=green ctermfg=blue
match ExtraWhitespace /\s\+$/


" disable compatibility with Vi
" compatibility with Vi does not work together
" well with some vim settings, e.g. filetype
" (see `help filetype`)
set nocompatible

set history=1000        " keep 1000 lines of command line history
set ruler               " show the cursor position all the time

" enable file type detection
filetype on
" load indentation rules and plugins
" according to the detected filetype.
filetype plugin on
filetype indent on

" jump to the last position when reopening a file
" source: /etc/vim/vimrc on debian 12 (bookworm)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" enables syntax highlighting by default.
syntax on

" force 16 color default scheme to be able to
" switch light/dark themes systemwide
set t_Co=16
colorscheme default

" add current line number
set number
" add relative numbers to current line
" to be able to quickly jump between lines with 23j or 32k
set relativenumber
" as numbers are relative there is no need to use default
" amount of numberwidth=4
set numberwidth=3

" make selection visible in light theme
highlight Visual ctermfg=Black ctermbg=DarkCyan cterm=NONE

" style for light and dark system theme
highlight CurrentWord      ctermfg=Black ctermbg=LightCyan cterm=NONE
highlight CurrentWordTwins ctermfg=NONE  ctermbg=NONE      cterm=underline

" Watch for external changes in files
set autoread


" enable auto completion menu after pressing TAB.
set wildmenu

" make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


" copy indent from current line when starting a new line
set autoindent

" number of spaces to use for each step of (auto)indent.
set shiftwidth=2

" do not use the appropriate number of spaces to insert a <Tab>.
set noexpandtab

" number of spaces that a <Tab> in the file counts for.
set tabstop=2

" highlight invisble stuff
set listchars=lead:·,trail:·,tab:>→,nbsp:%
set list
" highlight whitespaces at the end of lines
highlight ExtraWhitespace ctermbg=green ctermfg=blue
match ExtraWhitespace /\s\+$/

" use default mapping for https://github.com/bkad/CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

" enable vertial search for f/t using https://github.com/justinmk/vim-sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

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

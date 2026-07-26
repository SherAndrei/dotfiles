" clear status line when vimrc is reloaded.
set statusline=

" full path to the current file
set statusline+=%F

" modified flag: '[+]' if modified, '[-]' if unmodifiable, empty otherwise
set statusline+=\ %M

" readonly flag: '[RO]' if read‑only, empty otherwise
set statusline+=\ %R

" divider to separate the left side from the right side.
set statusline+=%=

" column number (cursor position)
set statusline+=\ %c

" current line number / total lines (slash escaped to be literal).
set statusline+=\ [%l\/%L]

" show the status on the second to last line always.
set laststatus=2

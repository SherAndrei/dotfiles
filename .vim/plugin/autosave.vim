
" Source: https://github.com/907th/vim-auto-save/blob/2e3e54ea4c0fc946c21b0a4ee4c1c295ba736ee8/plugin/AutoSave.vim#L131
" Not using the plugin since it became cumbersome while trying to support
" everyone

if exists("g:auto_save_loaded")
  finish
else
  let g:auto_save_loaded = 1
endif

function AutoSave()
  let was_modified = &modified
  if !was_modified
    return
  end

  silent! update
endfunction

augroup AutoSave
  autocmd!
  autocmd CursorHold,CursorHoldI * nested call AutoSave()
augroup END

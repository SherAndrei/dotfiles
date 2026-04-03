" ------------------------------------------------------------------
" Local 2clip and clip2 clipboard provider for Vim (no +clipboard needed)
" ------------------------------------------------------------------

if exists("g:loaded_2clip_clipboard") || !has('clipboard_provider')
  finish
endif
let g:loaded_2clip_clipboard = 1

func! IsToClipPresent()
    return executable('2clip') && executable('clip2')
endfunc

func! ToClipCopy(reg, type, lines)
    let content = join(a:lines, "\n")
    call system('2clip', content)
endfunc

func! ClipToPaste(reg)
    let raw = system('clip2')
    let raw = substitute(raw, "\r\n", "\n", 'g')

    return ["v", l:raw]
endfunc

if exists('v:clipproviders')
    let v:clipproviders['toclip'] = {
        \ 'available': function('IsToClipPresent'),
        \ 'copy': {'+': function('ToClipCopy'), '*': function('ToClipCopy')},
        \ 'paste': {'+': function('ClipToPaste'), '*': function('ClipToPaste')}
        \ }
    set clipmethod^=toclip
endif

" ------------------------------------------------------------------
" Windows clip.exe clipboard provider for Vim (no +clipboard needed)
" ------------------------------------------------------------------

" 1. Copy function: writes lines to clip.exe with proper line endings
func! WinClipCopy(reg, type, lines)
    " Join lines with Windows CRLF line endings
    let content = join(a:lines, "\r\n")
    " If it's a linewise yank, add a trailing CRLF (like Vim does)
    if a:type ==# "V"
        let content .= "\r\n"
    endif
    " Feed content to clip.exe
    call system('clip.exe', content)
endfunc

" 2. Paste function: retrieves clipboard content, converts to Vim lines
func! WinClipPaste(reg)
    " Get raw clipboard text using PowerShell (fast enough)
    let raw = system('powershell.exe -NoProfile -c Get-Clipboard -Raw')
    " Convert Windows CRLF to Unix LF
    let raw = substitute(raw, "\r\n", "\n", 'g')
    " Split into lines (preserve empty last line if present)
    let lines = split(raw, "\n", 1)
    " Determine register type:
    "   - If the clipboard ends with a newline → linewise ("V")
    "   - Otherwise → characterwise ("v")
    if empty(raw) || raw !~# '\n$'
        let type = "v"
    else
        let type = "V"
        " Remove the trailing empty line that split() creates
        if !empty(lines) && lines[-1] ==# ''
            call remove(lines, -1)
        endif
    endif
    return [type, lines]
endfunc

" 3. Register the provider in v:clipproviders (as per :help clipboard-provider)
if exists('v:clipproviders')
    let v:clipproviders['winclip'] = {
        \ 'available': {-> v:true},
        \ 'copy': {'+': function('WinClipCopy'), '*': function('WinClipCopy')},
        \ 'paste': {'+': function('WinClipPaste'), '*': function('WinClipPaste')}
        \ }
    " Make winclip the preferred provider
    set clipmethod^=winclip
endif

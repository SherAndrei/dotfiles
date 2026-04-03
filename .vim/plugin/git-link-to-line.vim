" Function: Link(line) – echoes GitHub URL for line number 'line'
function! Link(line) abort
  let l:line = a:line

  " Current file absolute path
  let l:file = expand('%:p')
  if empty(l:file)
    echo "No file name (buffer not saved?)"
    return
  endif

  " Find repository root (works inside submodules)
  let l:repo_root = system('git -C ' . shellescape(fnamemodify(l:file, ':h')) . ' rev-parse --show-toplevel 2>/dev/null')
  let l:repo_root = substitute(l:repo_root, '\n$', '', '')
  if v:shell_error || empty(l:repo_root)
    echo "Not in a Git repository"
    return
  endif

  " Relative path from repo root to current file
  let l:rel_path = strpart(l:file, len(l:repo_root) + 1)

  " Get remote URL (prefer 'origin', else first remote)
  let l:remote = system('git -C ' . shellescape(l:repo_root) . ' config --get remote.origin.url 2>/dev/null')
  let l:remote = substitute(l:remote, '\n$', '', '')
  if empty(l:remote)
    let l:first_remote = system('git -C ' . shellescape(l:repo_root) . ' remote 2>/dev/null | head -n1')
    let l:first_remote = substitute(l:first_remote, '\n$', '', '')
    if !empty(l:first_remote)
      let l:remote = system('git -C ' . shellescape(l:repo_root) . ' config --get remote.' . l:first_remote . '.url')
      let l:remote = substitute(l:remote, '\n$', '', '')
    endif
  endif

  if empty(l:remote)
    echo "No remote URL found"
    return
  endif

  " Convert SSH git@... to HTTPS URL, remove trailing .git
  let l:remote = substitute(l:remote, '^git@\([^:]*\):', 'https://\1/', '')
  let l:remote = substitute(l:remote, '\.git$', '', '')

  " Get current HEAD commit hash
  let l:commit = system('git -C ' . shellescape(l:repo_root) . ' rev-parse HEAD 2>/dev/null')
  let l:commit = substitute(l:commit, '\n$', '', '')
  if empty(l:commit)
    echo "No commit hash (detached HEAD?)"
    return
  endif

  " Build the GitHub URL
  let l:url = printf('%s/blob/%s/%s#L%d', l:remote, l:commit, l:rel_path, l:line)

  echo l:url
endfunction

" Command :Link – uses current line number
command! -nargs=0 Link call Link(line('.'))

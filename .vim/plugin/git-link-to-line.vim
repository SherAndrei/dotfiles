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

  let l:remote_HEAD_commit = system('git -C ' . shellescape(l:repo_root) . ' rev-parse origin/HEAD')
  let l:remote_HEAD_commit = substitute(l:remote_HEAD_commit, '\n$', '', '')
  if empty(l:remote_HEAD_commit)
    echo "Could not determine default branch of remote"
    return
  endif

  let l:local_commit = system('git -C ' . shellescape(l:repo_root) . ' rev-parse HEAD 2>/dev/null')
  let l:local_commit = substitute(l:local_commit, '\n$', '', '')
  if empty(l:local_commit)
    echo "No commit hash (detached HEAD?)"
    return
  endif

  let l:is_ancestor = system('git -C ' . shellescape(l:repo_root) . ' merge-base --is-ancestor ' . l:local_commit . ' ' . l:remote_HEAD_commit . ' 2>/dev/null')
  let l:pushed = (v:shell_error == 0)

  let l:ref = ''
  let l:use_line = 1

  if l:pushed
    let l:ref = l:local_commit
  else
    " Local commit not pushed → compare line content with remote
    let l:current_line = getline(l:line)

    let l:line_to_cmp_with = system('git -C ' . shellescape(l:repo_root) . ' show ' . shellescape(l:remote_HEAD_commit . ':' . l:rel_path) . ' | awk "NR==' . l:line . '"')
    let l:line_to_cmp_with = substitute(l:line_to_cmp_with, '\n$', '', '')

    if l:current_line !=# l:line_to_cmp_with
      echo "Warning: line content differs from remote. Linking without line number."
      let l:use_line = 0
    endif

    let l:ref = l:remote_HEAD_commit
  endif

  if l:use_line
    let l:url = printf('%s/blob/%s/%s#L%d', l:remote, l:ref, l:rel_path, l:line)
  else
    let l:url = printf('%s/blob/%s/%s', l:remote, l:ref, l:rel_path)
  endif

  if has('clipboard') || has('clipboard_provider')
    let @+ = l:url
    let l:url .= " (copied to clipboard)"
  endif

  echo l:url
endfunction

" Command :Link – uses current line number
command! -nargs=0 Link call Link(line('.'))

function! Link() range
  " Get the filename relative to repo root
  let l:repo_root = system('git rev-parse --show-toplevel 2>/dev/null | tr -d "\n"')
  if v:shell_error
    echo "Not in a git repository"
    return
  endif

  " Get current file path relative to repo root
  let l:file_path = expand('%')
  let l:full_path = fnamemodify(l:file_path, ':p')
  let l:relative_path = substitute(l:full_path, '^' . l:repo_root . '/', '', '')

  " Get current git remote URL and extract repo part
  let l:remote_url = system('git config --get remote.origin.url 2>/dev/null | tr -d "\n"')
  if v:shell_error || empty(l:remote_url)
    echo "No remote origin URL found"
    return
  endif

  " Convert git URL to HTTPS format if needed
  let l:repo_url = l:remote_url
  if l:repo_url =~ '^git@'
    " Convert git@github.com:user/repo.git to https://github.com/user/repo
    let l:repo_url = substitute(l:repo_url, '^git@\(.*\):', 'https://\1/', '')
    let l:repo_url = substitute(l:repo_url, '\.git$', '', '')
  elseif l:repo_url =~ '^https://'
    " Remove .git suffix if present
    let l:repo_url = substitute(l:repo_url, '\.git$', '', '')
  endif

  " Get current commit hash
  let l:commit_hash = system('git rev-parse HEAD 2>/dev/null | tr -d "\n"')
  if v:shell_error
    echo "Failed to get commit hash"
    return
  endif

  " Construct the URL
  let l:line_number = a:firstline
  let l:url = printf('%s/-/blob/%s/%s#L%d', l:repo_url, l:commit_hash, l:relative_path, l:line_number)

  " Echo the URL
  echo l:url
endfunction

" Command to call the function on current line
command! Link call Link()

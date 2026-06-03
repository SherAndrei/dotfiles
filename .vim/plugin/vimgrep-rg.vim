if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --color=never\ --glob=!.git\ --sort=none
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

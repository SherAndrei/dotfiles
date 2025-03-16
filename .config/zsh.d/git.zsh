
# wsl's git is slow on windows filesystem
# source: https://github.com/microsoft/WSL/issues/4401

function git() {
  autoload -U is_wsl

  if is_wsl && [[ "${PWD}" =~ "/mnt/\w/" ]]; then
    git.exe "$@"
  else
    command git "$@"
  fi
}

# This script is based on
# https://github.com/ohmyzsh/ohmyzsh/blob/6e7ac0544e71c7b777746cb50f70de68c6495b86/plugins/git/git.plugin.zsh

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions Current
# (sorted alphabetically by function name)
# (order should follow README)
#

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Check if main exists and use instead of master
function git_main_branch() {
  git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

#
# Aliases
# (sorted alphabetically by command)
# (order should follow README)
# (in some cases force the alisas order to match README, like for example gke and gk)
#

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

alias ga='git   add'
alias gaa='git  add --all'
alias gapa='git add --patch'
alias gau='git  add --update'
alias gav='git  add --verbose'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# Copied and modified from James Roeder (jmaroeder) under MIT License
# https://github.com/jmaroeder/plugin-git/blob/216723ef4f9e8dde399661c39c80bdf73f4076c4/functions/gbda.fish
function gbds() {
  local default_branch=$(git_main_branch)
  (( ! $? )) || return

  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch; do
      local merge_base=$(git merge-base $default_branch $branch)
      if [[ $(git cherry $default_branch $(git commit-tree $(git rev-parse $branch\^{tree}) -p $merge_base -m _)) = -* ]]; then
        git branch -D $branch
      fi
    done
}

alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcom='git checkout origin/$(git_main_branch)'

alias gcam='git  commit           --all --message'
alias gcm='git   commit                 --message'
alias gc='git    commit --verbose'
alias gca='git   commit --verbose                 --amend'
alias gcaa='git  commit --verbose --all           --amend'
alias gcan='git  commit --verbose                 --amend --no-edit'
alias gcaan='git commit --verbose --all           --amend --no-edit'

alias gd='git   diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git  diff --staged'
alias gdw='git  diff --word-diff'

function gdv() { git diff -w "$@" | view - }

alias gdup='git diff @{upstream}'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}

alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gf='git fetch'

alias glgg='git  log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git  log --graph --max-count=10'
alias glods='git log --graph            --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git  log --graph            --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph            --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph            --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git  log --graph            --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git   log         --decorate --oneline'
alias glog='git  log --graph --decorate --oneline  '
alias gloga='git log --graph --decorate --oneline --all'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}

alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gfg='git ls-files | grep'

alias gpf!='git push --force'
is-at-least 2.30 "$git_version" \
  && alias gpf='git push --force-with-lease --force-if-includes' \
  || alias gpf='git push --force-with-lease'

function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}

alias gpv='git push --verbose'
alias gpod='git push origin --delete'
alias ggpush='git push origin "$(git_current_branch)"'

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}

alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grim='git rebase --interactive origin/$(git_main_branch)'
alias grs='git rebase --skip'
alias grom='git rebase origin/$(git_main_branch)'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gst='git stash --all'
alias gstp='git stash pop'
alias gs='git status'
alias gss='git status --short'
alias gsu='git submodule update'
alias gsus='git submodule summary'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gstu='gsta --include-untracked'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'

unset git_version

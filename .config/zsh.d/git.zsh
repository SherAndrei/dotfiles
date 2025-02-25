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

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

#
# Functions Work in Progress (WIP)
# (sorted alphabetically by function name)
# (order should follow README)
#

# Similar to `gunwip` but recursive "Unwips" all recent `--wip--` commits not just the last one
function gunwipall() {
  local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)

  # Check if a commit without "--wip--" was found and it's not the same as HEAD
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

#
# Aliases
# (sorted alphabetically by command)
# (order should follow README)
# (in some cases force the alisas order to match README, like for example gke and gk)
#

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

alias ggpur='ggu'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# Copied and modified from James Roeder (jmaroeder) under MIT License
# https://github.com/jmaroeder/plugin-git/blob/216723ef4f9e8dde399661c39c80bdf73f4076c4/functions/gbda.fish
function gbds() {
  local default_branch=$(git_main_branch)
  (( ! $? )) || default_branch=$(git_develop_branch)

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

function gccd() {
  setopt localoptions extendedglob

  # get repo URI from args based on valid formats: https://git-scm.com/docs/git-clone#URLS
  local repo="${${@[(r)(ssh://*|git://*|ftp(s)#://*|http(s)#://*|*@*)(.git/#)#]}:-$_}"

  # clone repository and exit if it fails
  command git clone --recurse-submodules "$@" || return

  # if last arg passed was a directory, that's where the repo was cloned
  # otherwise parse the repo URI and use the last part as the directory
  [[ -d "$_" ]] && cd "$_" || cd "${${repo:t}%.git/#}"
}
compdef _git gccd=git-clone

alias gcam='git commit --all --message'
alias gcm='git commit --message'
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gcaa='git commit --verbose --all --amend'
alias gcan='git commit --verbose --no-edit --amend'
alias gcaan='git commit --verbose --all --no-edit --amend'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gdup='git diff @{upstream}'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gf='git fetch'
# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --tags --prune --jobs=10' \
  || alias gfa='git fetch --all --tags --prune'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ghh='git help'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gfg='git ls-files | grep'

alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase -v'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'

function ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'

function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout

alias gpf!='git push --force'
is-at-least 2.30 "$git_version" \
  && alias gpf='git push --force-with-lease --force-if-includes' \
  || alias gpf='git push --force-with-lease'

function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout

alias gpsup='git push --set-upstream origin $(git_current_branch)'
is-at-least 2.30 "$git_version" \
  && alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes' \
  || alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease'
alias gpv='git push --verbose'
alias gpoat='git push origin --all && git push origin --tags'
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
compdef _git ggp=git-checkout

alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
alias grom='git rebase origin/$(git_main_branch)'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gst='git stash --all'
alias gstp='git stash pop'
alias gs='git status'
alias gss='git status --short'
alias gsu='git submodule update'
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
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

unset git_version

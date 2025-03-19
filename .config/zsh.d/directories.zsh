
# cd works like pushd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

cf() {
    local dir=$(find -L ${1:-.} -mindepth 1 -path "*/\.git" -prune -o -type d -print |
        fzf --height 40% --reverse --preview="tree -CN {}")
    [[ -z $dir ]] || { print -s cd $dir ; cd $dir }
}

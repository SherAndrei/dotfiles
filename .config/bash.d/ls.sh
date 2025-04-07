
# source: https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html

alias ls='ls --color=auto'

LS_OPTIONS=""

LS_OPTIONS="${LS_OPTIONS} -l" # use a long listing format
LS_OPTIONS="${LS_OPTIONS} --human-readable" # print sizes like 1K 234M 2G etc.
LS_OPTIONS="${LS_OPTIONS} -v" # natural sort of (version) numbers within text

alias l="ls  ${LS_OPTIONS} --almost-all"
alias ll="ls ${LS_OPTIONS}"

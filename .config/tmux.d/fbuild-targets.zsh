#!/usr/bin/env zsh

function usage() {
    [[ $# -ge 1 ]] && echo >&2 "error: $@"
    cat >&2 <<EOF
Usage: ${0##*/} [--query=<pattern>] [--fbuild=<path>]

Interactive build target finder using fzf.

This script calls fbuild with the -showtargets option to list available build targets,
removes the header (first line) and footer (last line), and uses fzf for interactive fuzzy search.
Optional parameters:
  --query=<pattern>      Start fzf with given query, more about search patter here:
                         https://github.com/junegunn/fzf?tab=readme-ov-file#search-syntax
  --fbuild=<path>        Use the specified fbuild executable instead of one in PATH.
EOF
    exit 2
}

QUERY=""
FBUILD="fbuild"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --query=*)
            QUERY="${1#--query=}"
            shift
            ;;
        --fbuild=*)
            FBUILD="${1#--fbuild=}"
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            usage "unexpected argument: $1"
            ;;
    esac
done

set -e

"$FBUILD" -showtargets |
	sed --expression '1d;$d' --expression='s/\n//' |
	fzf --query="$QUERY"

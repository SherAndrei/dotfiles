#!/usr/bin/env zsh

function usage() {
	[[ $# -ge 1 ]] && echo >&2 error: "$@"
	cat >&2 <<EOF
Usage: ${0##*/} [--separator=<separator>] <directory>

Interactive file finder using fzf.

This script interactively searches for files, directories, and symbolic links
in a specified directory. It excludes any ".git" directories from the search,
cleans up the output paths, and uses fzf to allow the user to choose one or
multiple items interactively with a preview (using less).

Requirements:
  - zsh shell
  - fzf: A command-line fuzzy finder (https://github.com/junegunn/fzf)
  - less: For previewing file contents
EOF
	exit 2
}

separator='\n'

if [[ "$1" == --separator=* ]]; then
	separator="${1#--separator=}"
	shift
fi

if [ "$#" -lt 1 ]; then
	usage "missing positional argument <directory>"
fi

set -e

cd $1

__get_file_preview_renderer() {
	if command -v bat 2>&1 1>/dev/null; then
		echo "bat --color=always --decorations=always --style=numbers";
	elif command -v less 2>&1 1>/dev/null; then
		echo "less --LINE-NUMBERS --chop-long-lines";
	else
		echo "cat";
	fi
}

__get_directory_preview_renderer() {
	if command -v tree 2>&1 1>/dev/null; then
		echo "tree -CN";
	else
		echo "ls --color=always --almost-all";
	fi
}

find . \
		-mindepth 1 \
		-path "*/.git" -prune \
		-o \( -type f -o -type d -o -type l \) \
		-print \
	| cut \
		--characters=3- \
	| fzf \
		--layout=reverse \
		--multi          \
		--preview="([[ -d {} ]] && $(__get_directory_preview_renderer) {}) || ([[ -f {} ]] && $(__get_file_preview_renderer) {}) || echo {}" \
	| while read fn; do
		# Output each selected file name with proper quoting.
		printf "%s%b" ${(q)fn} ${separator}
	done

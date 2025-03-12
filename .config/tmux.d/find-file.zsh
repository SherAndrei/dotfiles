#!/usr/bin/env zsh
#
# find-file.zsh: Interactive file finder using fzf.
#
# This script interactively searches for files, directories, and symbolic links
# in a specified directory. It excludes any ".git" directories from the search,
# cleans up the output paths, and uses fzf to allow the user to choose one or
# multiple items interactively with a preview (using less).
#
# Usage:
#   find-file.zsh [--separator=<separator>] <directory>
#
# Requirements:
#   - zsh shell
#   - fzf: A command-line fuzzy finder (https://github.com/junegunn/fzf)
#   - less: For previewing file contents

separator='\n'

if [[ "$1" == --separator=* ]]; then
	separator="${1#--separator=}"
	shift
fi

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 [--separator=<separator>] <directory>"
	exit 1
fi

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <directory>"
	exit 1
fi

set -e

cd $1

find . -mindepth 1 -path "*/.git" -prune -o \( -type f -o -type d -o -type l \) -print |
	cut --characters=3- |
	fzf --multi --preview="less --LINE-NUMBERS --chop-long-lines {}" |
	while read fn; do
		# Output each selected file name with proper quoting.
		printf "%s%b" ${(q)fn} ${separator}
	done

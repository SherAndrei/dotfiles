
CONFIG_DIR="${HOME}/.config"

# These are sorted alphabetically
. "${CONFIG_DIR}/gcc.d/colors.sh"
. "${CONFIG_DIR}/less.d/options.sh"
. "${CONFIG_DIR}/rg.d/options.sh"

SH_CONFIG_DIR="${HOME}/.config/sh.d"

# These are sorted alphabetically

BASH_CONFIG_DIR="${HOME}/.config/bash.d"

# These are sorted alphabetically
. "$BASH_CONFIG_DIR"/completion.sh
. "$BASH_CONFIG_DIR"/history.sh
. "$BASH_CONFIG_DIR"/ls.sh
. "$BASH_CONFIG_DIR"/prompt.sh

unset BASH_CONFIG_DIR
unset SH_CONFIG_DIR
unset CONFIG_DIR

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# removes flickering in git bash
# source: https://stackoverflow.com/a/79019988
bind 'set bell-style none'

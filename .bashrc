
SH_CONFIG_DIR="${HOME}/.config/sh.d"

# These are sorted alphabetically
. "$SH_CONFIG_DIR"/less.sh

unset SH_CONFIG_DIR

BASH_CONFIG_DIR="${HOME}/.config/bash.d"

# These are sorted alphabetically
. "$BASH_CONFIG_DIR"/ls.sh

unset BASH_CONFIG_DIR

# removes flickering in git bash
# source: https://stackoverflow.com/a/79019988
bind 'set bell-style none'


SH_CONFIG_DIR="${HOME}/.config/sh.d"

# These are sorted alphabetically
. "$SH_CONFIG_DIR"/less.sh

BASH_CONFIG_DIR="${HOME}/.config/bash.d"

# These are sorted alphabetically
. "$BASH_CONFIG_DIR"/ls.sh

# removes flickering in git bash
# source: https://stackoverflow.com/a/79019988
bind 'set bell-style none'

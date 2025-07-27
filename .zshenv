
# .zshenv is sourced in all possible combinations of {login,non-login} and {interactive,non-interactve} shells

CONFIG_DIR="${HOME}/.config"

# These are sorted alphabetically
. "${CONFIG_DIR}/fzf.d/env.sh"
. "${CONFIG_DIR}/homebrew.d/env.sh"

unset CONFIG_DIR

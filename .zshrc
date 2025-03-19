
CONFIG_DIR="${HOME}/.config"

# These are sorted alphabetically
. "${CONFIG_DIR}/fzf.d/options.sh"
. "${CONFIG_DIR}/gcc.d/colors.sh"
. "${CONFIG_DIR}/less.d/options.sh"
. "${CONFIG_DIR}/rg.d/options.sh"

SH_CONFIG_DIR="${HOME}/.config/sh.d"

# These are sorted alphabetically

BASH_CONFIG_DIR="${HOME}/.config/bash.d"

# These are sorted alphabetically
. "$BASH_CONFIG_DIR"/ls.sh

ZSH_CONFIG_DIR="${HOME}/.config/zsh.d"

# These are sorted alphabetically
. "$ZSH_CONFIG_DIR"/autosuggestions.zsh
. "$ZSH_CONFIG_DIR"/completion.zsh
. "$ZSH_CONFIG_DIR"/directories.zsh
. "$ZSH_CONFIG_DIR"/git.zsh
. "$ZSH_CONFIG_DIR"/history.zsh
. "$ZSH_CONFIG_DIR"/keybindings.zsh
. "$ZSH_CONFIG_DIR"/prompt.zsh

export PATH="$SH_CONFIG_DIR/scripts:$PATH"
export PATH="$BASH_CONFIG_DIR/scripts:$PATH"
export PATH="$ZSH_CONFIG_DIR/scripts:$PATH"

export FPATH="$SH_CONFIG_DIR/functions:$FPATH"
export FPATH="$BASH_CONFIG_DIR/functions:$FPATH"
export FPATH="$ZSH_CONFIG_DIR/functions:$FPATH"

# Created by `pipx`
export PATH="$PATH:${HOME}/.local/bin"

# must be at the end of .zshrc
# source: https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#faq
. "$ZSH_CONFIG_DIR"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unset ZSH_CONFIG_DIR
unset BASH_CONFIG_DIR
unset SH_CONFIG_DIR
unset CONFIG_DIR

# Disable beeping
setopt NO_BEEP

# Recognize comments on the command line
setopt INTERACTIVE_COMMENTS

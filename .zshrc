
BASH_CONFIG_DIR="${HOME}/.config/bash.d"

# These are sorted alphabetically
. "$BASH_CONFIG_DIR"/ls.sh

ZSH_CONFIG_DIR="${HOME}/.config/zsh.d"

# These are sorted alphabetically
. "$ZSH_CONFIG_DIR"/completion.zsh
. "$ZSH_CONFIG_DIR"/directories.zsh
. "$ZSH_CONFIG_DIR"/git.zsh
. "$ZSH_CONFIG_DIR"/history.zsh
. "$ZSH_CONFIG_DIR"/keybindings.zsh
. "$ZSH_CONFIG_DIR"/prompt.zsh
. "$ZSH_CONFIG_DIR"/zsh-autosuggestions/zsh-autosuggestions.zsh

export FPATH="$ZSH_CONFIG_DIR/functions:$FPATH"

# Disable beeping
setopt NO_BEEP

# Recognize comments on the command line
setopt INTERACTIVE_COMMENTS

# Created by `pipx`
export PATH="$PATH:${HOME}/.local/bin"

# must be at the end of .zshrc
# source: https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#faq
. "$ZSH_CONFIG_DIR"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

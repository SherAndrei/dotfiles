
ZSH_CONFIG_DIR="${HOME}/.config/zsh.d"

# These are sorted alphabetically
. "$ZSH_CONFIG_DIR"/completion.zsh
. "$ZSH_CONFIG_DIR"/git.zsh
. "$ZSH_CONFIG_DIR"/history.zsh
. "$ZSH_CONFIG_DIR"/keybindings.zsh
. "$ZSH_CONFIG_DIR"/prompt.zsh
. "$ZSH_CONFIG_DIR"/zsh-autosuggestions/zsh-autosuggestions.zsh

# Disable beeping
setopt NO_BEEP

# Recognize comments on the command line
setopt INTERACTIVE_COMMENTS

# Created by `pipx`
export PATH="$PATH:${HOME}/.local/bin"

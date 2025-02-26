
# Do not save commands starting with a space to history
setopt HIST_IGNORE_SPACE

# If a command is a duplicate of any previous command, remove the older copy
setopt HIST_IGNORE_ALL_DUPS

# Save commands to history as you run them and import the commands run in other terminals into history
setopt SHARE_HISTORY

# Save history to .zsh_history in your home folder
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

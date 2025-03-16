
# see zshoptions(1)

# Do not save commands starting with a space to history
setopt HIST_IGNORE_SPACE

# If a command is a duplicate of any previous command, remove the older copy
setopt HIST_IGNORE_ALL_DUPS

# Save commands to history as you run them and import the commands run in other terminals into history
setopt SHARE_HISTORY

# Do not beep in ZLE when a widget attempts to access a history
# entry which isn't there.
unsetopt HIST_BEEP

# Save history to .zsh_history in your home folder
HISTFILE=~/.zsh_history
HISTSIZE=2147483647
SAVEHIST=$HISTSIZE

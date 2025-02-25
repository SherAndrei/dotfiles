# share history between all opened zsh terminals
setopt share_history

# removes copies of lines still in the history list, keeping the newly added one
setopt hist_ignore_all_dups

HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096


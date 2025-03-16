
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# erase previous lines matching the current from the history
HISTCONTROL="${HISTCONTROL}:erasedups"

# save all line of a multiple-line command in the same history entry
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

HISTFILE=~/.bash_history
HISTSIZE=-1
HISTFILESIZE=$HISTSIZE

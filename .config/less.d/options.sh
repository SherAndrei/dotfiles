# sourcable with /bin/sh

LESS=""

# enable case-insensitive search;
# option is ignored if any upper case letters
# appear in the search patter
LESS="${LESS} --ignore-case"

# enable ANSI sequences, e.g. colors
LESS="${LESS} --RAW-CONTROL-CHARS"

# exit if the entire file can be displayed on the first screen
LESS="${LESS} --quit-if-one-screen"

# disable clearing the screen at the start and after quitting
LESS="${LESS} --no-init"

# highlight first new unread line
LESS="${LESS} --HILITE-UNREAD"

# show two lines before and after matched symbol
LESS="${LESS} --jump-target=2"

# provide useful info in prompt
# NB: must be the last option in the LESS
# source: man less(1)
LESS="${LESS} --prompt=s?f%f .?m(%i/%m) .%lt-%lb?L/%L. [%bB?B/%B.]?B %pB\%.?x N\:%x.%t"

export LESS

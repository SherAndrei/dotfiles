
FZF_DEFAULT_OPTS=""

# Enable processing of ANSI color codes
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --ansi"

# Display on the same line with the default separator ' < '
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --info=inline"

# Set default terminal background/foreground color to basic ANSI
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"

# Number of spaces for a tab character
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --tabstop=2"

# Bind <Alt+Up> and <Alt+Down> to navigate preview
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind 'alt-down:preview-down,alt-up:preview-up'"

export FZF_DEFAULT_OPTS

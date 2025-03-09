
# source: https://github.com/sindresorhus/pure

fpath+=( "$ZSH_CONFIG_DIR"/pure )

# extended ascii symbols instead of default UTF-8
# source: https://github.com/sindresorhus/pure/wiki/Customizations,-hacks-and-tweaks#safer-symbols
PURE_PROMPT_SYMBOL='»'
PURE_GIT_DOWN_ARROW='↓'
PURE_GIT_UP_ARROW='↑'

# xterm-256color system blue (bold blue as in `ls` directory color '\e[01;34m')
# source: https://www.ditig.com/256-colors-cheat-sheet
zstyle :prompt:pure:path color 12

autoload -U promptinit;
promptinit

prompt pure

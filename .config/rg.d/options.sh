: ${CONFIG_DIR:?}

# colorscheme is in ANSI colors similar to the silver searcher (ag)
# source: https://github.com/BurntSushi/ripgrep/blob/master/FAQ.md#silver-searcher-output

# other parameters are used for convenient use with fzf and vim
# inspired by https://github.com/junegunn/fzf.vim/blob/245eaf8e50fe440729056ce8d4e7e2bb5b1ff9c9/plugin/fzf.vim
RIPGREP_CONFIG_PATH="${CONFIG_DIR}/rg.d/.ripgreprc"
export RIPGREP_CONFIG_PATH

# use zoxide in favor of cd
# source: https://github.com/ajeetdsouza/zoxide/blob/095b270fea283ed0a9d147c2b154a80030f19a4c/README.md
if command -v zoxide 2>&1 >/dev/null; then
  eval "$(zoxide init zsh --cmd cd)";
fi

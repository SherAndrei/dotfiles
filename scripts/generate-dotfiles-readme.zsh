#!/bin/zsh

echo "# Dotfiles"
echo

scripts/md-tree.zsh \
    --exclude .gitmodules \
    --exclude .pre-commit-config.yaml \
    --exclude .stow-local-ignore \
    --exclude README.md \
    --exclude-dir .config/zsh.d/pure \
    --exclude-dir .config/zsh.d/zsh-autosuggestions \
    --exclude-dir .git \
    --exclude-dir scripts \
    --exclude-dir tmp \

cat <<'EOF'
---

Install using [GNU Stow](https://www.gnu.org/software/stow/):
1. Clone repo into home directory
  ```bash
  git clone https://github.com/SherAndrei/dotfiles.git ~/.dotfiles
  ```
2. Run `stow` from repo
  ```bash
  cd ~/.dotfiles
  stow .
  cd -
  ```
EOF

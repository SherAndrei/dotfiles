#!/bin/zsh

echo "# Dotfiles"
echo

scripts/md-tree.zsh \
    --exclude .gitmodules \
    --exclude .pre-commit-config.yaml \
    --exclude .stow-local-ignore \
    --exclude README.md \
    --exclude-dir .config/zsh.d/pure \
    --exclude-dir .git \
    --exclude-dir scripts \
    --exclude-dir tmp \

#!/bin/zsh

echo "# Dotfiles"
echo

scripts/md-tree.zsh \
    --exclude .pre-commit-config.yaml \
    --exclude .stow-local-ignore \
    --exclude README.md \
    --exclude-dir .git \
    --exclude-dir scripts \

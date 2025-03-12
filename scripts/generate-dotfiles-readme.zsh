#!/bin/zsh

echo "# Dotfiles"
echo

exclude_files=()
exclude_dirs=()

exclude_files+=(".gitmodules")
exclude_files+=(".pre-commit-config.yaml")
exclude_files+=(".stow-local-ignore")
exclude_files+=("README.md")

exclude_dirs+=(".config/zsh.d/pure")
exclude_dirs+=(".config/zsh.d/zsh-autosuggestions")
exclude_dirs+=(".config/zsh.d/zsh-syntax-highlighting")
exclude_dirs+=(".git")
exclude_dirs+=("scripts")

untracked_files=("${(@f)$(git ls-files --others --exclude-standard)}")

for item in "${untracked_files[@]}"; do
  if [ -d "$item" ]; then
    exclude_dirs+=("$item")
  else
    exclude_files+=("$item")
  fi
done

set -- $(echo ${exclude_files[@]/#/--exclude } ${exclude_dirs[@]/#/--exclude-dir })
scripts/md-tree.zsh $@

# scripts/md-tree.zsh $result
#  ${exclude_files[@]/#/--exclude } \
#  ${exclude_dirs[@]/#/--exclude-dir }

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

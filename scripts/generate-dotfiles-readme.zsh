#!/bin/zsh

echo "# Dotfiles"
echo

exclude_files=()
exclude_dirs=()

exclude_files+=(".gitmodules")
exclude_files+=(".pre-commit-config.yaml")
exclude_files+=(".stow-local-ignore")
exclude_files+=("README.md")

exclude_dirs+=(".git")
exclude_dirs+=("scripts")

untracked_files=("${(@f)$(git ls-files --others --exclude-standard)}")

for item in "${untracked_files[@]}"; do
  if [ -d "$item" ]; then
    exclude_dirs+=("$item")
  elif [ -f "$item" ]; then
    exclude_files+=("$item")
  fi
done

submodules=("${(@f)$(git submodule --quiet foreach 'echo ${sm_path}')}")

for submodule in "${submodules[@]}"; do
	exclude_dirs+=("$submodule")
done

set -- $(echo ${exclude_files[@]/#/--exclude } ${exclude_dirs[@]/#/--exclude-dir })
scripts/md-tree.zsh $@

cat <<'EOF'
---

### Installation

Install using [GNU Stow](https://www.gnu.org/software/stow/):
1. Clone repo into home directory
  ```bash
  git clone --recurse-submodules --jobs=8 https://github.com/SherAndrei/dotfiles.git ~/.dotfiles
  ```
2. Run `stow` from repo
  ```bash
  cd ~/.dotfiles
  stow .
  cd -
  ```
3. (optionally) Provide code completion and syntax highlighting for C-family languages, [source](https://github.com/ycm-core/YouCompleteMe/tree/b6e8c64d96b02d60b3751d6a51af7dc958054f8f?tab=readme-ov-file#linux-64-bit)
  ```bash
  sudo apt install build-essential cmake vim-nox python3-dev
  cd ~/.vim/pack/code/start/YouCompleteMe
  python3 install.py --clangd-completer
  ```
  Tested with:
  * Python 3.10.12
  * cmake version 3.22.1
  * VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Feb 03 2025 11:54:38)
  * gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

---

### Contributing

Several rules to abide:
1. User defined configuration for each application gets its directory in `.config` directory. To differentiate between user defined and application defined configuration, `.d` suffix is preferred.
1. Curious and maybe useful scripts with usage of the application must be placed into the `.config/${SHELL}.d` directory, e.g. best directory to put `git` aliases to is `bash.d` as `alias` is a `bash` builtin function (see bash(1)).
1. Write as much portable code as possible, meaning if it is `bash` script, but it can be converted to `sh` script only by changing `[[...]]` to `[...]` one should go for it.
1. More about shell scripting:
	1. Callable shell scripts must contain correct shebang.
	1. If script's purpose is to be sourced elsewhere, please provide some indication in place of the shebang if it is not obvious where the script can be sourced, e.g. although `bash` uses `.sh` suffix for scripts, they cannot be sourced in `sh` shell.
	1. If one is sourcing other scripts, one should avoid glob (see glob(3)), as they are hard to manage, meaing they are bound to be replaced to non-globs in future.
EOF

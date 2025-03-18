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
exclude_dirs+=(".vim/pack/themes/start/vim-code-dark")
exclude_dirs+=(".tmux/plugins/tpm")
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

set -- $(echo ${exclude_files[@]/#/--exclude } ${exclude_dirs[@]/#/--exclude-dir })
scripts/md-tree.zsh $@

cat <<'EOF'
---

### Installation

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

# Dotfiles

- [.bashrc](./.bashrc)
- [Brewfile](./Brewfile)
- [.config](./.config)
  - [bash.d](./.config/bash.d)
    - [completion.sh](./.config/bash.d/completion.sh)
    - [grep.sh](./.config/bash.d/grep.sh)
    - [history.sh](./.config/bash.d/history.sh)
    - [less.sh](./.config/bash.d/less.sh)
    - [ls.sh](./.config/bash.d/ls.sh)
    - [prompt.sh](./.config/bash.d/prompt.sh)
  - [bat.d](./.config/bat.d)
    - [config](./.config/bat.d/config)
    - [env.sh](./.config/bat.d/env.sh)
  - [Code](./.config/Code)
    - [User](./.config/Code/User)
      - [settings.json](./.config/Code/User/settings.json)
  - [fzf.d](./.config/fzf.d)
    - [env.sh](./.config/fzf.d/env.sh)
  - [gcc.d](./.config/gcc.d)
    - [colors.sh](./.config/gcc.d/colors.sh)
  - [homebrew.d](./.config/homebrew.d)
    - [env.sh](./.config/homebrew.d/env.sh)
  - [less.d](./.config/less.d)
    - [options.sh](./.config/less.d/options.sh)
  - [pypoetry](./.config/pypoetry)
    - [config.toml](./.config/pypoetry/config.toml)
  - [rg.d](./.config/rg.d)
    - [options.sh](./.config/rg.d/options.sh)
    - [.ripgreprc](./.config/rg.d/.ripgreprc)
  - [sh.d](./.config/sh.d)
    - [functions](./.config/sh.d/functions)
      - [is_wsl](./.config/sh.d/functions/is_wsl)
    - [scripts](./.config/sh.d/scripts)
      - [2clip](./.config/sh.d/scripts/2clip)
      - [clip2](./.config/sh.d/scripts/clip2)
  - [zsh.d](./.config/zsh.d)
    - [autosuggestions.zsh](./.config/zsh.d/autosuggestions.zsh)
    - [completion.zsh](./.config/zsh.d/completion.zsh)
    - [directories.zsh](./.config/zsh.d/directories.zsh)
    - [git.zsh](./.config/zsh.d/git.zsh)
    - [history.zsh](./.config/zsh.d/history.zsh)
    - [keybindings.zsh](./.config/zsh.d/keybindings.zsh)
    - [prompt.zsh](./.config/zsh.d/prompt.zsh)
    - [scripts](./.config/zsh.d/scripts)
      - [ff](./.config/zsh.d/scripts/ff)
      - [fp](./.config/zsh.d/scripts/fp)
      - [.fp.swp](./.config/zsh.d/scripts/.fp.swp)
      - [rr](./.config/zsh.d/scripts/rr)
- [.editorconfig](./.editorconfig)
- [.gitconfig](./.gitconfig)
- [.gitignore](./.gitignore)
- [.hushlogin](./.hushlogin)
- [.inputrc](./.inputrc)
- [.tmux](./.tmux)
- [.tmux.conf](./.tmux.conf)
  - [plugins](./.tmux/plugins)
- [.vim](./.vim)
  - [pack](./.vim/pack)
    - [code](./.vim/pack/code)
      - [start](./.vim/pack/code/start)
    - [themes](./.vim/pack/themes)
      - [start](./.vim/pack/themes/start)
  - [plugin](./.vim/plugin)
    - [bracketed-paste.vim](./.vim/plugin/bracketed-paste.vim)
    - [disable-builtin.vim](./.vim/plugin/disable-builtin.vim)
    - [hard.vim](./.vim/plugin/hard.vim)
    - [search.vim](./.vim/plugin/search.vim)
    - [statusline.vim](./.vim/plugin/statusline.vim)
    - [ycmrc.vim](./.vim/plugin/ycmrc.vim)
- [.vimrc](./.vimrc)
- [.zprofile](./.zprofile)
- [.zshenv](./.zshenv)
- [.zshrc](./.zshrc)
---

### Installation

Install utilties using [Homebrew](https://brew.sh/):
1. Run Homebrew installation script from official site
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
2. Install applications listed in `Brewfile`
  ```zsh
  brew bundle
  ```

Generate symlinks to configuration using [GNU Stow](https://www.gnu.org/software/stow/):
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

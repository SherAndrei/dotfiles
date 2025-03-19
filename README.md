# Dotfiles

- [.bashrc](./.bashrc)
- [.config](./.config)
  - [Code](./.config/Code)
    - [User](./.config/Code/User)
      - [settings.json](./.config/Code/User/settings.json)
  - [bash.d](./.config/bash.d)
    - [completion.sh](./.config/bash.d/completion.sh)
    - [history.sh](./.config/bash.d/history.sh)
    - [ls.sh](./.config/bash.d/ls.sh)
    - [prompt.sh](./.config/bash.d/prompt.sh)
  - [fzf.d](./.config/fzf.d)
    - [options.sh](./.config/fzf.d/options.sh)
  - [gcc.d](./.config/gcc.d)
    - [colors.sh](./.config/gcc.d/colors.sh)
  - [less.d](./.config/less.d)
    - [options.sh](./.config/less.d/options.sh)
  - [pypoetry](./.config/pypoetry)
    - [config.toml](./.config/pypoetry/config.toml)
  - [rg.d](./.config/rg.d)
    - [.ripgreprc](./.config/rg.d/.ripgreprc)
    - [options.sh](./.config/rg.d/options.sh)
  - [sh.d](./.config/sh.d)
    - [functions](./.config/sh.d/functions)
      - [is_wsl](./.config/sh.d/functions/is_wsl)
  - [tmux.d](./.config/tmux.d)
    - [.find-file.zsh.swp](./.config/tmux.d/.find-file.zsh.swp)
    - [find-file.zsh](./.config/tmux.d/find-file.zsh)
  - [zsh.d](./.config/zsh.d)
    - [autosuggestions.zsh](./.config/zsh.d/autosuggestions.zsh)
    - [completion.zsh](./.config/zsh.d/completion.zsh)
    - [directories.zsh](./.config/zsh.d/directories.zsh)
    - [git.zsh](./.config/zsh.d/git.zsh)
    - [history.zsh](./.config/zsh.d/history.zsh)
    - [keybindings.zsh](./.config/zsh.d/keybindings.zsh)
    - [prompt.zsh](./.config/zsh.d/prompt.zsh)
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
    - [apps](./.vim/pack/apps)
      - [start](./.vim/pack/apps/start)
        - [fzf](./.vim/pack/apps/start/fzf)
          - [plugin](./.vim/pack/apps/start/fzf/plugin)
            - [fzf.vim](./.vim/pack/apps/start/fzf/plugin/fzf.vim)
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
- [.vimrc](./.vimrc)
- [.zshrc](./.zshrc)
- [Session.vim](./Session.vim)
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

# Dotfiles

- [.bashrc](./.bashrc)
- [.config](./.config)
  - [pypoetry](./.config/pypoetry)
    - [config.toml](./.config/pypoetry/config.toml)
  - [zsh.d](./.config/zsh.d)
    - [completion.zsh](./.config/zsh.d/completion.zsh)
    - [directories.zsh](./.config/zsh.d/directories.zsh)
    - [functions](./.config/zsh.d/functions)
      - [is_wsl](./.config/zsh.d/functions/is_wsl)
    - [git.zsh](./.config/zsh.d/git.zsh)
    - [history.zsh](./.config/zsh.d/history.zsh)
    - [keybindings.zsh](./.config/zsh.d/keybindings.zsh)
    - [prompt.zsh](./.config/zsh.d/prompt.zsh)
- [.gitconfig](./.gitconfig)
- [.gitignore](./.gitignore)
- [.zshrc](./.zshrc)
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

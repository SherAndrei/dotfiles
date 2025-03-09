# Dotfiles

- [.bashrc](./.bashrc)
- [.config](./.config)
  - [Code](./.config/Code)
    - [User](./.config/Code/User)
      - [settings.json](./.config/Code/User/settings.json)
  - [bash.d](./.config/bash.d)
    - [ls.sh](./.config/bash.d/ls.sh)
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
- [.editorconfig](./.editorconfig)
- [.gitconfig](./.gitconfig)
- [.gitignore](./.gitignore)
- [.vimrc](./.vimrc)
- [.zprofile](./.zprofile)
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

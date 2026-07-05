CD_CMD="builtin cd"

# use zoxide in favor of cd
# source: https://github.com/ajeetdsouza/zoxide/blob/095b270fea283ed0a9d147c2b154a80030f19a4c/README.md
if command -v zoxide 2>&1 >/dev/null; then
  eval "$(zoxide init zsh --cmd cd)";
  functions -c cd zoxide_cd
  CD_CMD="zoxide_cd"
fi

function cd() {
  local target="$1"

  if [[ -z "$target" ]]; then
    eval "$CD_CMD"
    return $?
  fi

  autoload -U is_wsl
  if is_wsl;
  then
    # NB: for some unusual reason wslpath appends paths to mounted dirs
    #     with one more /mnt prefix as they are differ from other paths
    if [[ ! "${target}" =~ '/mnt/' ]]; then
      local converted
      converted=$(wslpath -u "$target" 2>/dev/null)
      if [[ $? -eq 0 && -n "$converted" ]]; then
        target="$converted"
      fi
    fi
  fi;

  eval "$CD_CMD" "$target"
}


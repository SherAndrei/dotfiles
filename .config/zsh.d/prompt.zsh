
# get info from Version Control System
# source: https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b'

function _create_lprompt {
  local prompt=""

  # Current working directory
  # source: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Shell-state
  prompt+="%F{white}%~%f "

  # Load git information
  prompt+="%F{green}${vcs_info_msg_0_}%f "

  # Input character
  prompt+="$"

  echo $prompt
}

function _create_rprompt {
  local prompt=""

  # Current time of day in 24-hour format, with seconds.
  # In green.
  # source: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Date-and-time
  prompt+=" %F{cyan}%*%f"

  echo $prompt
}

# allows command substitution in the prompt (and parameter expansion and arithmetic expansion)
setopt PROMPT_SUBST
PROMPT='$(_create_lprompt) '
RPROMPT='$(_create_rprompt)'


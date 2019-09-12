export LSCOLORS=ExFxBxDxCxegedabagacad
export TZ="${TZ:-America/New_York}"
export TERM="${TERM:-xterm-256color}"

# Set preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif [[ -n $EDITOR ]]; then
  if command -v subl &> /dev/null; then
    export EDITOR="subl -n -w"
  elif command -v nvim &> /dev/null; then
    export EDITOR="nvim"
  else
    export EDITOR="vim"
  fi
fi

export VISUAL=${VISUAL:-code}
export PAGER=${PAGER:-less}

# Set path
path=(
  $HOME/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  /usr/local/share/npm/bin
  .
  $path
)

typeset -gxU path

# plugin values and other variables
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# exports
export TZ="${TZ:-America/New_York}"
export TERM="${TERM:-xterm-256color}"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # https://help.github.com/articles/associating-text-editors-with-git/
  # export EDITOR="subl -n -w"
  export EDITOR='nvim'
fi
export VISUAL='code'
export PAGER='less'

if [[ -n $ZSH_VERSION ]]; then
  # Set path
  path=(
    $HOME/bin
    /usr/local/{sbin,bin}
    /usr/local/share/npm/bin
    /usr/{sbin,bin}
    /{sbin,bin}
    $path
  )

  typeset -gxU path
fi

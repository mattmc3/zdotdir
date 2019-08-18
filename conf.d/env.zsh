export DOTFILES="$HOME/.dotfiles"
export LSCOLORS=ExFxBxDxCxegedabagacad
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

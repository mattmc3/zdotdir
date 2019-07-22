source "$ZSH"/lib/history.zsh

if [[ -n $XDG_DATA_HOME ]]; then
  HISTFILE="$XDG_DATA_HOME"/zsh/zsh_history
else
  HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
fi
HISTSIZE=100000
SAVEHIST=100000

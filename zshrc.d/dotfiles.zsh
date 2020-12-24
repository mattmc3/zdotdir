if [[ -z $DOTFILES ]]; then
  if [[ -d "${XDG_CONFIG_HOME:-~/.config}/dotfiles" ]]; then
    export DOTFILES="${XDG_CONFIG_HOME:-~/.config}/dotfiles"
  elif [[ -d ~/.dotfiles ]]; then
    export DOTFILES=~/.dotfiles
  fi
fi

alias cddotf='cd "$DOTFILES"'
alias dotf='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

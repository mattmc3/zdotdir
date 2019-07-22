# dotfiles
if [[ ! -z $XDG_CONFIG_HOME ]]; then
  export DOTFILES="${DOTFILES:-$XDG_CONFIG_HOME/dotfiles}"
  export DOTFILES_LOCAL="${DOTFILES_LOCAL:-$XDG_CONFIG_HOME/dotfiles.local}"
else
  export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
  export DOTFILES_LOCAL="${DOTFILES_LOCAL:-$HOME/.dotfiles.local}"
fi
alias dotf='cd "$DOTFILES" && $VISUAL .'
alias dotfl='cd "$DOTFILES_LOCAL" && $VISUAL .'

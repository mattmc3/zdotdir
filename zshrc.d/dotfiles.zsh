export DOTFILES=~/.config/dotfiles
alias cddotf='cd "$DOTFILES"'
alias dotf='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

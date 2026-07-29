# dotfiles
: ${DOTFILES:=$HOME/.dotfiles}
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'
alias dotfl="cd \$DOTFILES/local"
alias fdot='cd ${XDG_CONFIG_HOME:-$HOME/.config}/fish'
alias fconf=fdot
alias zdot='cd $ZDOTDIR'

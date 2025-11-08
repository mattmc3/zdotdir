#
# zoxide: Configure zoxide.
#

(( $+commands[zoxide] )) || return 1
source <(zoxide init zsh)

# let's make sure run-help uses the Zsh built-in rather than the man alias
unalias run-help
autoload run-help
alias help=run-help

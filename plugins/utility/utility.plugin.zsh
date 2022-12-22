#
# Configure Zsh utilities.
#

# built-in paste magic
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load more specific zsh 'run-help' function.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

# zsh benchmarking
path=(
  $ZPLUGINDIR/.external/zsh-bench
  $path
)

# zman
source $ZPLUGINDIR/.external/zman/zman.zsh

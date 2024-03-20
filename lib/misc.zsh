#
# misc: Setup misc Zsh utils, common aliases, and other miscellany.
#

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

# It's time. Python2 is dead.
if (( $+commands[python3] )) && ! (( $+commands[python] )); then
  alias python=python3
fi

# Ensure envsubst command exists.
if ! (( $+commands[envsubst] )) && (( $+commands[python] )); then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi

# Ensure hd (hex dump) command exists.
if ! (( $+commands[hd] )) && (( $+commands[hexdump] )); then
  alias hd="hexdump -C"
fi

# Ensure open command exists.
if ! (( $+commands[open] )); then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif (( $+commands[xdg-open] )); then
    alias open='xdg-open'
  fi
fi

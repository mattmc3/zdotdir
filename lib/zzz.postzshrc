#!/bin/zsh
#
# zzz - Sleepily wait until the end of .zshrc and then run as one-time precmd.
#

# Init aliases.
[[ -r ${ZDOTDIR:-~}/.zaliases ]] && source ${ZDOTDIR:-~}/.zaliases

# Init completions.
if ! zstyle -t ':myzsh:feature:completion:compinit' loaded; then
  mycompinit
fi

# Run zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

#!/bin/zsh
##? .zshenv - Zsh environment file, loaded always.

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Use .zprofile for remaining environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

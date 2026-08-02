#!/usr/bin/env zsh

typeset -gUa path fpath prepath

prepath=(
  $HOME/bin(N)
  /opt/homebrew/bin(N)
  $HOME/.local/bin(N)
)
path=(
  $prepath
  $path
)

export SHELL_SESSIONS_DISABLE=1
export EDITOR=nvim
export VISUAL=code

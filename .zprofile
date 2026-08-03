#!/usr/bin/env zsh

typeset -gUa path fpath prepath cdpath

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}

# Apps
export EDITOR=nvim
export VISUAL=code
export PAGER=less
export SHELL_SESSIONS_DISABLE=1

# Set the path elements that should always be first
prepath=(
  $HOME/bin(N)
  /opt/homebrew/bin(N)
  $HOME/.local/bin(N)
)
path=( $prepath $path )

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
  $XDG_PROJECTS_DIR/mattmc3(N/)
  $cdpath
)

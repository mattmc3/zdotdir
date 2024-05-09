#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

is_wsl() {
    uname -a | grep -qi Microsoft && return 0 || return 1
}
#
# XDG
#

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

for xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
  [[ -e ${(P)xdgdir} ]] || mkdir -p ${(P)xdgdir}
done

#
# Browser
#

if is_wsl; then
  # check if wslview is installed
  # if not, install it
  if ! command -v wslview &> /dev/null; then
    echo "wslview not found, pls install it"
  else
    export BROWSER="${BROWSER:-wslview}"
  fi
fi

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

#
# Editors
#

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"

#
# Regional Settings
#

export TZ="Germany/Berlin"
export LANG="${LANG:-en_US.UTF-8}"

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath mailpath

# set the list of directories that `cd` searches
# cdpath=(
#   ~/Projects
#   $cdpath
# )

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

path+=("/mnt/c/Users/ndges/AppData/Local/Programs/Microsoft VS Code/bin")
path+=("/mnt/c/Windows/SysWow64")

#
# Less
#

# Set default less options.
export LESS="${LESS:--g -i -M -R -S -w -z-4}"

# Set the less input preprocessor.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Misc
#

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Make Apple Terminal behave
export SHELL_SESSIONS_DISABLE=1

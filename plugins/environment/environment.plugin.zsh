#
# XDG base dirs
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}
for xdir in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_RUNTIME_DIR; do
  [[ -d $xdir ]] || mkdir -p $xdir
done
unset xdir

#
# Editors
#

export EDITOR=${EDITOR:-vim}
export VISUAL=${VISUAL:-vim}
export PAGER=${PAGER:-less}

#
# Path
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath

path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

#
# Less
#

export LESS=${LESS:-'-g -i -M -R -S -w -z-4'}

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER=${BROWSER:-open}
fi

#
# Misc
#

# use `< file` to quickly view the contents of any file.
export READNULLCMD=${READNULLCMD:-$PAGER}

# XDG: Stop apps from polluting your home directory. Prefixing files with a
# dot to hide them is not enough to control the clutter on a modern system.
# See README.md for more.
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# Make sure XDG dirs are set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

VERIFY_XDG="${VERIFY_XDG:-true}"

function verify_appdir {
  local xdgdir="$1"
  local homedir="$2"

  if [[ -d "$xdgdir" ]]; then
    if [[ -d "$homedir" ]]; then
      echo "XDG split-brain error! Both $homedir and $xdgdir exist." | sed "s|$HOME|~|g"
      return 1
    fi
  elif [[ -d "$homedir" ]]; then
    echo "Moving existing $homedir to $xdgdir" | sed "s|$HOME|~|g"
    mv "$homedir" "$xdgdir"
  else
    mkdir -p "$xdgdir"
  fi
}

function verify_appfile {
  local xdgfile="$1"
  local homefile="$2"
  local contents="$3"

  if [[ -f "$xdgfile" ]]; then
    if [[ -f "$homefile" ]]; then
      echo "XDG split-brain error! Both $homefile and $xdgfile exist." | sed "s|$HOME|~|g"
      return 1
    fi
  else
    local xdgdir=$( dirname "$xdgfile" )
    [[ -d "$xdgdir" ]] || mkdir -p "$xdgdir"
    if [[ -f "$xdgfile" ]]; then
      echo "Moving existing $homefile to $xdgfile" | sed "s|$HOME|~|g"
      mv "$homefile" "$xdgfile"
    else
      echo "$contents" > "$xdgfile"
    fi
  fi
}

#
# atom
#
if type apm &> /dev/null; then
  export ATOM_HOME="$XDG_CONFIG_HOME"/atom
  [[ $VERIFY_XDG == true ]] && verify_appdir "$ATOM_HOME" "$HOME"/.atom
fi

#
# docker and docker-machine
#
if type docker &> /dev/null; then
  if type docker-machine &> /dev/null; then
    export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
    [[ $VERIFY_XDG == true ]] && verify_appdir "$MACHINE_STORAGE_PATH" "$HOME"/.docker/machine
  fi
  export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
  [[ $VERIFY_XDG == true ]] && verify_appdir "$DOCKER_CONFIG" "$HOME"/.docker
fi

#
# gnupg
#
if type gpg &> /dev/null || type gpg2 &> /dev/null; then
  export GNUPGHOME="$XDG_DATA_HOME"/gnupg
  [[ $VERIFY_XDG == true ]] && verify_appdir "$GNUPGHOME" "$HOME"/.gnupg
fi

#
# ipython/jupyter
#
if type ipython &> /dev/null || type jupyter &> /dev/null; then
  export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
  [[ $VERIFY_XDG == true ]] && verify_appdir "$IPYTHONDIR" "$HOME"/.ipython
  export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
  [[ $VERIFY_XDG == true ]] && verify_appdir "$JUPYTER_CONFIG_DIR" "$HOME"/.jupyter
fi

#
# less
#
if type less &> /dev/null; then
  export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
  [[ $VERIFY_XDG == true ]] && verify_appfile "$LESSKEY" "$HOME"/.less
  export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
  [[ $VERIFY_XDG == true ]] && verify_appfile "$LESSHISTFILE" "$HOME"/.lesshst
fi

#
# npm
#
if type npm &> /dev/null; then
  npmrc=$(cat <<EOF
prefix=\${XDG_DATA_HOME}/npm
cache=\${XDG_CACHE_HOME}/npm
tmp=\${XDG_RUNTIME_DIR}/npm
init-module=\${XDG_CONFIG_HOME}/npm/config/npm-init.js
EOF
)
  export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
  [[ $VERIFY_XDG == true ]] && verify_appfile "$NPM_CONFIG_USERCONFIG" "$HOME"/.npmrc "$npmrc"
fi

#
# python
#
if type python3 &> /dev/null || type virtualenv &> /dev/null; then
  export WORKON_HOME="$XDG_DATA_HOME"/venvs
  [[ $VERIFY_XDG == true ]] && verify_appdir "$WORKON_HOME" "$HOME"/.virtualenvs
fi

#
# python-pylint
#
if type pylint &> /dev/null; then
  export PYLINTHOME="$XDG_CACHE_HOME"/pylint
  [[ $VERIFY_XDG == true ]] && verify_appdir "$PYLINTHOME" "$HOME"/.pylint.d
fi

#
# readline
#
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
[[ $VERIFY_XDG == true ]] && verify_appfile "$INPUTRC" "$HOME"/.inputrc

#
# screen
#
if type screen &> /dev/null; then
  export SCREENRC="$XDG_CONFIG_HOME"/screen/.screenrc
  [[ $VERIFY_XDG == true ]] && verify_appfile "$SCREENRC" "$HOME"/.screenrc
fi

#
# subversion
#
if type svn &> /dev/null; then
  [[ $VERIFY_XDG == true ]] && verify_appdir "$XDG_CONFIG_HOME"/subversion "$HOME"/.svn
  alias svn="command svn --config-dir \"$XDG_CONFIG_HOME\"/subversion"
fi

#
# sqlite
#
if type sqlite3 &> /dev/null; then
  export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite/sqlite_history
  [[ $VERIFY_XDG == true ]] && verify_appfile "$SQLITE_HISTORY" "$HOME"/.sqlite_history
fi

#
# tmux
#
if type tmux &> /dev/null; then
  export TMUX_CONFIG="$XDG_CONFIG_HOME"/tmux/tmux.conf
  [[ $VERIFY_XDG == true ]] && verify_appfile "$TMUX_CONFIG" "$HOME"/.tmux.conf
  # tmux devs are stubborn turkeys (that's the nice version)
  # We can't just set a variable, we instead have to alias tmux to use XDG
  # https://github.com/tmux/tmux/issues/142
  alias tmux='command tmux -f "$TMUX_CONFIG"'
fi

#
# todo.sh (todo.txt)
#
if type todo.sh &> /dev/null; then
  export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todo-txt/config
  verify_appfile "$TODOTXT_CFG_FILE" "$HOME"/.todo/config
fi

#
# wget
#
if type wget &> /dev/null; then
  wgetrc_contents=$(cat <<EOF
hsts-file = $XDG_CACHE_HOME/wget-hsts
EOF
)
  export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
  verify_appfile "$WGETRC" "$HOME"/.wgetrc "$wgetrc_contents"
fi

#
# z
#
if type z &> /dev/null; then
  export _Z_DATA="$XDG_DATA_HOME/z/data"
  verify_appfile "$_Z_DATA" "$HOME"/.z
fi

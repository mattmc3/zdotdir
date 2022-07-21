# apps -
#   define variables for different apps

# homebrew
if [[ "$OSTYPE" == darwin* ]]; then
  if [[ -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  else
    export HOMEBREW_PREFIX=/usr/local
  fi
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX";
  export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
fi

# groovy
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=$HOMEBREW_PREFIX/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi

# golang
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH

# lpass
export LPASS_AGENT_TIMEOUT="${LPASS_AGENT_TIMEOUT:-0}"

# python
export WORKON_HOME="$XDG_DATA_HOME/venvs"
[[ -d "$WORKON_HOME" ]] || mkdir -p "$WORKON_HOME"

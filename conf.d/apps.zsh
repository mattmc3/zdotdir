# go
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH

# groovy
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=$HOMEBREW_PREFIX/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi

# homebrew
if [[ "$OSTYPE" == darwin* ]] && (( $+commands[brew] )); then
  if [[ "${commands[brew]}" == "/opt/homebrew/bin/brew" ]]; then
    HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/opt/homebrew}
  else
    HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/usr/local}
  fi
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX";
  export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
fi

# lpass
export LPASS_AGENT_TIMEOUT="${LPASS_AGENT_TIMEOUT:-0}"

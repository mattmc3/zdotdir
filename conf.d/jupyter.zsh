export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
JUPYTER_HOME="${JUPYTER_HOME:-$HOME/Projects/jupyter}"
[[ -d $JUPYTER_HOME ]] || mkdir -p $JUPYTER_HOME

function juno {
  if [[ -n "$1" ]]; then
    cd "$1"
  else
    cd "$JUPYTER_HOME"
  fi
  jupyter notebook
}

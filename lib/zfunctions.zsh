export ZFUNCDIR=${ZDOTDIR:-~/.config/zsh}/functions

function autoload-dir {
  [[ -d "$1" ]] || return 1
  fpath+="$1"
  local fn
  for fn in "$1"/*(.N); do
    autoload -Uz $fn
  done
}
autoload-dir "$ZFUNCDIR"

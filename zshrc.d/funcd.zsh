ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath+="$ZFUNCDIR"
() {
  local fn
  for fn in $ZFUNCDIR/**/*(.N); do
    autoload -Uz $fn
  done
}

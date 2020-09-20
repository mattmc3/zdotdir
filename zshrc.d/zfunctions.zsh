# Adds support for a ${ZDOTDIR:-$HOME}/zfunctions directory to contain
# lazy-loaded zsh functions
ZFUNCDIR="${ZDOTDIR:-$HOME}/zfunctions"
[[ -d "$ZFUNCDIR" ]] || mkdir -p "$ZFUNCDIR"
fpath=("$ZFUNCDIR" $fpath)

for _zfunc in "$ZFUNCDIR"/*(.N); do
  autoload -Uz "$_zfunc"
done
unset _zfunc

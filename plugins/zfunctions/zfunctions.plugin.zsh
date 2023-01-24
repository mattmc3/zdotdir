# Autoload functions directory.
: ${ZFUNCDIR:=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}/zsh}/functions}
[[ -d $ZFUNCDIR ]] || return 1

# Autoload funcdir and subdirs
for funcdir in $ZFUNCDIR $ZFUNCDIR/*(N/); do
  fpath=($funcdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset funcdir

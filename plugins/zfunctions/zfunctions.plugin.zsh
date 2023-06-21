# zfunctions
# Adds support for a functions directory to contain lazy-loaded zsh functions
0=${(%):-%N}

# Autoload functions directory.
: ${ZFUNCDIR:=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}/zsh}/functions}
[[ -d $ZFUNCDIR ]] || return 1

# Autoload funcdir and subdirs
for funcdir in ${0:A:h}/functions $ZFUNCDIR $ZFUNCDIR/*(FN/); do
  fpath=($funcdir $fpath)
  autoload -Uz $funcdir/*(.:t)
done
unset funcdir

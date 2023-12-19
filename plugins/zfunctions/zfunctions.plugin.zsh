##? zfunctions - Use autoload functions directory for Zsh functions.

# Set $0.
0=${(%):-%N}

# Use $ZFUNCDIR as functions directory.
: ${ZFUNCDIR:=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}/zsh}/functions}
[[ -d $ZFUNCDIR ]] || mkdir -p $ZFUNCDIR

# Autoload Zsh function dir and its subdirs.
for _zfuncdir in ${0:a:h}/functions $ZFUNCDIR $ZFUNCDIR/*(N/); do
  fpath=($_zfuncdir $fpath)
  autoload -Uz $_zfuncdir/*(.:t)
done
unset _zfuncdir

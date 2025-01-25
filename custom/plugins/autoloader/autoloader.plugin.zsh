# autoloader - autoload functions in $ZSH_CUSTOM/functions

# Allow the user to override the $ZSH_CUSTOM/functions directory
: ${ZFUNCDIR:="$ZSH_CUSTOM/functions"}
[[ -d "$ZFUNCDIR" ]] || return 1

_zautoloads=($ZFUNCDIR/*(N.:t))
(( $#_zautoloads > 0 )) && autoload -Uz $_zautoloads
unset _zautoloads

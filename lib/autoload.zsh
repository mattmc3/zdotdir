#
# autoload: Autoload all function files in a directory.
#

##? Autoload function files in directory
function autoload-dir {
  local zdir
  local -a zautoloads
  for zdir in $@; do
    [[ -d "$zdir" ]] || continue
    fpath=("$zdir" $fpath)
    zautoloads=($zdir/*~_*(N.:t))
    (( $#zautoloads > 0 )) && autoload -Uz $zautoloads
  done
}

# Load zfunctions.
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${ZFUNCDIR:=$__zsh_config_dir/functions}
autoload-dir $ZFUNCDIR(N/) $ZFUNCDIR/*(N/)

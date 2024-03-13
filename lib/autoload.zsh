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
autoload-dir $__zsh_config_dir/functions(N/) $__zsh_config_dir/functions/*(N/)

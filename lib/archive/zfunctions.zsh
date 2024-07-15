#
# zfunctions: Autoload all function files from your $ZDOTDIR/functions directory.
#

##? autoload-dir - Autoload function files in directory
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

##? funcsave - Save a function
function funcsave {
  emulate -L zsh; setopt local_options
  : ${ZFUNCDIR:=$__zsh_config_dir/functions}

  # check args
  if (( $# == 0 )); then
    echo >&2 "funcsave: Expected at least 1 args, got only 0."
    return 1
  elif ! typeset -f "$1" > /dev/null; then
    echo >&2 "funcsave: Unknown function '$1'."
    return 1
  elif [[ ! -d "$ZFUNCDIR" ]]; then
    echo >&2 "funcsave: Directory not found '$ZFUNCDIR'."
    return 1
  fi

  # make sure the function is loaded in case it's already lazy
  autoload +X "$1" > /dev/null

  # remove first/last lines (ie: 'function foo {' and '}') and de-indent one level
  type -f "$1" | awk 'NR>2 {print prev} {gsub(/^\t/, "", $0); prev=$0}' >| "$ZFUNCDIR/$1"
}

##? funced - edit the function specified
function funced {
  emulate -L zsh; setopt local_options
  : ${ZFUNCDIR:=$__zsh_config_dir/functions}

  # check args
  if (( $# == 0 )); then
    echo >&2 "funced: Expected at least 1 args, got only 0."
    return 1
  elif [[ ! -d "$ZFUNCDIR" ]]; then
    echo >&2 "funced: Directory not found '$ZFUNCDIR'."
    return 1
  fi

  # new function definition: make a file template
  if [[ ! -f "$ZFUNCDIR/$1" ]]; then
    local -a funcstub
    funcstub=(
      "#\!/bin/zsh"
      "#function $1 {"
      ""
      "#}"
      "#$1 \"\$@\""
    )
    printf '%s\n' "${funcstub[@]}" > "$ZFUNCDIR/$1"
    autoload -Uz "$ZFUNCDIR/$1"
  fi

  # open the function file
  if [[ -n "$VISUAL" ]]; then
    $VISUAL "$ZFUNCDIR/$1"
  else
    ${EDITOR:-vim} "$ZFUNCDIR/$1"
  fi
}

##? funcfresh - Reload an autoload function
function funcfresh {
  if (( $# == 0 )); then
    echo >&2 "funcfresh: Expecting function argument."
    return 1
  elif ! (( $+functions[$1] )); then
    echo >&2 "funcfresh: Function not found '$1'."
    return 1
  fi
  unfunction $1
  autoload -Uz $1
}

# Autoload ZFUNCDIR
: ${ZFUNCDIR:=$__zsh_config_dir/functions}
if [[ -d "$ZFUNCDIR" ]]; then
  # Load zfunctions.
  autoload-dir $__zsh_config_dir/functions(N/) $__zsh_config_dir/functions/*(N/)
fi

0=${(%):-%x}
autoload-dir ${0:A:h}/functions

typeset -gHa _string_funcopts=( local_options extended_glob no_monitor )

function string {
  emulate -L zsh; setopt $_string_funcopts
  if ! (( $+functions[string-${1}] )); then
    echo >&2 "string: Subcommand '${1}' is not valid."
    return 2
  fi

  local cmd=$1; shift

  # collect stdin (ie: <redirected, piped|)
  if [[ ! -t 0 ]]; then
    local -a piped=()
    local data
    while IFS= read -r data || [[ -n "$data" ]]; do
      piped+=($data)
    done
    set -- "$@" "${piped[@]}"
  fi

  string-${cmd} "$@"
  return $?
}

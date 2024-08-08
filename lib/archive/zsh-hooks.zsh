# SOURCE: https://github.com/zsh-hooks/zsh-hooks
# LICENSE: https://github.com/zsh-hooks/zsh-hooks/blob/master/LICENCE

# Add to HOOK the given FUNCTION.
#
# With -d, remove the function from the hook instead; delete the hook
# variable if it is empty.
#
# -D behaves like -d, but pattern characters are active in the
# function name, so any matching function will be deleted from the hook.
#
# Without -d, the FUNCTION is marked for autoload; -U is passed down to
# autoload if that is given, as are -z and -k.  (This is harmless if the
# function is actually defined inline.)


hooks-add-hook(){

  emulate -L zsh

  local opt
  local -a autoopts
  integer del list help

  while getopts "dDhLUzk" opt; do
    case "$opt" in
      (d) del=1 ;;
      (D) del=2 ;;
      (h) help=1 ;;
      (L) list=1 ;;
      ([Uzk]) autoopts+=("-$opt") ;;
      (*) return 1 ;;
    esac
  done
  shift $(( OPTIND - 1 ))

  if (( list )); then
    if [[ -z "$1" ]]; then
      printf '%s: What hook do you want listed?\n' "${funcstack[@]}" >&2
      return 1
    fi
    typeset -mp $@
    return $?
  elif (( help || $# != 2 )); then
    print -u$(( 2 - help )) $usage
    return $(( 1 - help ))
  fi

  local hook="${1}"
  local fn="$2"

  if (( del )); then
    # delete, if hook is set
    if (( ${(P)+hook} )); then
      if (( del == 2 )); then
        set -A $hook ${(P)hook:#${~fn}}
      else
        set -A $hook ${(P)hook:#$fn}
      fi
      # unset if no remaining entries --- this can give better
      # performance in some cases
      if (( ! ${(P)#hook} )); then
        unset $hook
      fi
    fi
  else
    if (( ${(P)+hook} )); then
      if (( ${${(P)hook}[(I)$fn]} == 0 )); then
        set -A $hook ${(P)hook} $fn
      fi
    else
      set -A $hook $fn
    fi
    autoload $autoopts -- $fn
  fi

}

hooks-run-hook(){
  local f
  for f in ${(P)1}; do
    $f ${@:2} # send given args to the func
  done
}

hooks-define-hook(){
  typeset -ag "$1"
}

-hooks-define-zle-hook(){
    local hname
    hname="${1//-/_}"  # substitute all `-` with `_`
    eval "
        hooks-define-hook ${hname}_hook
        ${1}(){
            ZSH_CUR_KEYMAP=\$KEYMAP
            hooks-run-hook ${hname}_hook
        }
        zle -N ${1}
        "
}

# Add the special widgets defined at:
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Special-Widgets
-hooks-define-zle-hook zle-isearch-exit
-hooks-define-zle-hook zle-isearch-update
-hooks-define-zle-hook zle-line-pre-redraw
-hooks-define-zle-hook zle-line-init
-hooks-define-zle-hook zle-line-finish
# this one causes a double-free error for zaw using the ag source
# because it does some funny stuff with the history.  Anyway,
# since as far as I know nobody uses or wants to use this hook,
# I'll comment it out until such a time as this issue is fixed...
#-hooks-define-zle-hook zle-history-line-set
-hooks-define-zle-hook zle-keymap-select

# load the official hooks as well
autoload -U add-zsh-hook

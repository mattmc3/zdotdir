# zprof if we ever need to profile
[[ $ZPROF != true ]] || zmodload zsh/zprof

# source all files in config dir
_confdirs=(
  "${ZDOTDIR:-$HOME}/.zshrc.d"
  "${ZDOTDIR:-$HOME/.config/zsh}/zshrc.d"
  "${ZDOTDIR:-$HOME/.config/zsh}/conf.d"
)
for _d in $_confdirs; do
  [[ -d $_d ]] || continue
  _files=("$_d"/*.{sh,zsh})
  for _f in ${(o)_files}; do
    # ignore files that begin with a tilde
    case ${_f:t} in '~'*) continue;; esac
    source "$_f"
  done
done
unset _confdirs _d _f _files

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

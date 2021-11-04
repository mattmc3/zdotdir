# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof

# use conf.d to drive .zshrc
() {
  local confd="${ZDOTDIR:-$HOME/.config/zsh}/conf.d"
  local files=("$confd"/*.{sh,zsh}(.N))
  local f
  for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

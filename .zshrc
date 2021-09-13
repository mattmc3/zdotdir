# load zprof first if we need to profile
[[ ${ZSH_PROFILE_RC:-0} -eq 0 ]] || zmodload zsh/zprof

# helpful profiling aliases
alias zprofrc="ZSH_PROFILE_RC=1 zsh"
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'

# source all scripts in a config dir
function src_confd {
  local files=("$1"/*.{sh,zsh}(.N))
  local f; for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}

() {
  local confdirs=(
    "${ZDOTDIR:-$HOME}/.zshrc.d"
    "${ZDOTDIR:-$HOME/.config/zsh}/zshrc.d"
    "${ZDOTDIR:-$HOME/.config/zsh}/conf.d"
  )
  local d; for d in $confdirs; do
    [[ -d $d ]] || continue
    src_confd $d
  done
}

# done profiling
[[ ${ZSH_PROFILE_RC:-0} -eq 0 ]] || { unset ZSH_PROFILE_RC && zprof }

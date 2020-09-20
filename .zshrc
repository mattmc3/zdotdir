# zprof if we ever need to profile
alias runzprof="RUNZPROF=1 zsh"
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'
[[ $RUNZPROF -ne 1 ]] || zmodload zsh/zprof

# everything else is in zshrc.d
function () {
  local f
  for f in "$ZDOTDIR"/zshrc.d/**/*.{sh,zsh}(.N); do
    # ignore files that begin with a tilde
    case $f:t in ~*) continue;; esac
    source "$f"
  done
}

# done profiling
[[ $RUNZPROF -ne 1 ]] || { unset RUNZPROF && zprof }

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# source everything from conf.d
() {
  local f
  for f in $ZDOTDIR/zshrc.d/*.zsh(N); do
    [[ ${f:t} != '~'* ]] || continue
    source "$f"
  done
}

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

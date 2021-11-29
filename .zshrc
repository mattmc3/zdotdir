# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# use plugins to drive our config
source $ZDOTDIR/zlib/plugins.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

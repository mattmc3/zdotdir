# zprof if we ever need to profile
alias runzprof="RUNZPROF=1 zsh"
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'
[[ $RUNZPROF -ne 1 ]] || zmodload zsh/zprof

# my whole config is a plugin chain
source $ZDOTDIR/zlib/antibody.zsh

# initialize completions
run_compinit

# done profiling
[[ $RUNZPROF -ne 1 ]] || { unset RUNZPROF && zprof }

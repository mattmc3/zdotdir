# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

# history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=200000
SAVEHIST=100000

# config
set extended_glob
bindkey -e
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
prompt fire

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

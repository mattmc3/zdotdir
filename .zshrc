#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# run 'ZSH_PROFILE_RC=1 zsh; zprof' if we need to profile
[[ -z "$ZSH_PROFILE_RC" ]] || zmodload zsh/zprof
alias zprofrc="ZSH_PROFILE_RC=1 zsh; zprof"
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

# config
set extended_glob
bindkey -e
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
prompt fade

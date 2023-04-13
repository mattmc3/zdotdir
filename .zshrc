#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# Load zprof first if we need to profile.
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load zstyles.
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

# Setup antidote.
ANTIDOTE_HOME=$ZDOTDIR/plugins/.external
ZPREZTODIR=$ANTIDOTE_HOME/sorin-ionescu/prezto
zplugins=$ZDOTDIR/.zplugins
source $ZDOTDIR/.antidote/antidote.zsh
#source ~/Projects/mattmc3/antidote/antidote.zsh
if [[ ! ${zplugins}.zsh -nt $zplugins ]]; then
  (antidote bundle < $zplugins >| ${zplugins}.zsh)
fi
source ${zplugins}.zsh

# Local settings/overrides.
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

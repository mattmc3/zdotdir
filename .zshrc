#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# Load zprof first if we need to profile.
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load P10 instaprompt next.
[[ ${ZPROFRC:-0} -eq 0 ]] || typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load zstyles.
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

# Setup antidote plugins.
ANTIDOTE_HOME=$ZDOTDIR/.antidote/.plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

# Local settings/overrides.
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# p10 insta-prompt
source $ZDOTDIR/plugins/p10k-instaprompt/p10k-instaprompt.plugin.zsh

# init functions
fpath+=($ZDOTDIR/functions/zshinit)
autoload -Uz zshinit && zshinit

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zstyle config
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# libs
for zfile in $ZDOTDIR/lib/*.zsh(.N); source $zfile
unset zfile

# Load aliases.
[[ -f $ZDOTDIR/.zaliases ]] && source $ZDOTDIR/.zaliases

# Local settings/overrides.
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

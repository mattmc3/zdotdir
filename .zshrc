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

# init functions
fpath+=($ZDOTDIR/functions/zshinit)
autoload -Uz zshinit && zshinit

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

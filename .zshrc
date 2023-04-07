#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load zstyles.
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Use functions dir like Fish.
for _fndir in $ZDOTDIR/functions(/N) $ZDOTDIR/functions/*(/N); do
  fpath=($_fndir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset _fndir

# Use completions dir like Fish.
fpath=($ZDOTDIR/completions(/N) $fpath)

# setup Zsh
zsh_plugins
zsh_color
zsh_directory
zsh_editor
zsh_history
zsh_utilities
zsh_completion
zsh_compstyle

# Source anything in conf.d like Fish.
for _rcfile in $ZDOTDIR/conf.d/*.{z,}sh(N); do
  source $_rcfile
done
unset _rcfile

# Local settings/overrides.
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

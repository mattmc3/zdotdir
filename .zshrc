#!/bin/zsh
# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Zstyles
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Autoload functions directory.
fpath=($ZDOTDIR/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Use antidote plugins to drive config
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Zsh options
setopt extended_glob no_beep no_hist_beep

# Source eveything in conf.d
for _rcfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  source "$_rcfile"
done
unset _rcfile

# local settings/overrides
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

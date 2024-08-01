#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load .zstyles file with customizations.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Setup prompt near the top so we can get instant prompt if we need it.
zstyle -a ':zephyr:plugin:prompt' theme 'ZSH_THEME' || ZSH_THEME=(starship zephyr)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] &&
   [[ "$ZSH_THEME" == (p10k|powerlevel10k) ]]
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load things from lib.
for zlib in antidote transient-prompt; do
  source $ZDOTDIR/lib/${zlib}.zsh
done
unset zlib

# Add more zsh config here, or in conf.d...
# ...

# Add aliases.
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Uncomment to manually initialize completion system if you want, or let Zephyr
# do it automatically in the zshrc-post hook.
# ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump
# [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
# autoload -Uz compinit && compinit -i -d $ZSH_COMPDUMP

# Uncomment to manually set your prompt, or let Zephyr do it automatically in the
# zshrc-post hook. Note that some prompts like powerlevel10k may not work well
# with post_zshrc.
# setopt prompt_subst
# autoload -Uz promptinit && promptinit
# prompt $ZSH_THEME
# if [[ "$ZSH_THEME" == starship* ]]; then
#   source $ZDOTDIR/lib/starship-transient-prompt.zsh
# fi

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC
true

#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load .zstyles file first.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Load things from lib.
for zlib in antidote; do
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
# zshrc-post hook. Also, note that some prompts like powerlevel10k may not work
# well with post_zshrc.
autoload -Uz promptinit && promptinit
prompt p10k mmc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC
true

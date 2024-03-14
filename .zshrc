#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# If you are using Powerlevel10k prompt, and want to use instant prompt, uncomment this.
# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load all the kickstart.zsh libs.
for _zrc in $ZDOTDIR/lib/*.zsh; source $_zrc; unset _zrc

# Add more zsh config here, or in conf.d...
# ...

# Uncomment to manually initialize completion system if you want, or let kickstart.zsh
# do it automatically.
# ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump
# [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h
# autoload -Uz compinit && compinit -i -d $ZSH_COMPDUMP

# Uncomment to manually set your prompt, or let kickstart.zsh do it automatically.
autoload -Uz promptinit && promptinit
prompt p10k mmc

# IMPORTANT: Run zshrc-post at the very end of your .zshrc. If you don't, kickstart.zsh
# will try to run it for you via a precmd hook, which might work fine, but might
# cause problems with certain plugins/prompts (eg: Powerlevel10k).
zshrc-post

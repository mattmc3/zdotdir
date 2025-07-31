#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# # Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add custom completions
fpath=(${ZDOTDIR:-$HOME/.config/zsh}/completions $fpath)

# Lazy-load (autoload) Zsh function files from a directory.
# ZFUNCDIR=${ZDOTDIR:-$HOME/.config/zsh}/functions
# fpath=($ZFUNCDIR $fpath)
# autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Set zsh_custom dev location for use in antidote plugins.
ZSH_CUSTOM_DEV=$HOME/Projects/mattmc3/zsh_custom

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME/.config/zsh}/lib/antidote.zsh

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

# Never start in the root file system. Looking at you, Zed.
[[ "$PWD" != "/" ]] || cd

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true

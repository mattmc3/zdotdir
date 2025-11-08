#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Setup profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Run this early so we can P10k instant prompt if we need it.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Zsh location vars.
ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p $ZSH_CONFIG_DIR $ZSH_DATA_DIR $ZSH_CACHE_DIR

# Set zstyle configs
[[ -r $ZSH_CONFIG_DIR/.zstyles ]] && source $ZSH_CONFIG_DIR/.zstyles

# Initialize Zsh features.
fpath+=($ZSH_CONFIG_DIR/inits)
autoload -Uz optinit && optinit
autoload -Uz envinit && envinit --use-xdg-base-dirs
autoload -Uz histinit && histinit
autoload -Uz colorinit && colorinit
autoload -Uz toolinit && toolinit
autoload -Uz funcinit && funcinit
autoload -Uz confdinit && confdinit

# Initialize prompt.
autoload -Uz promptinit && promptinit
prompt powerlevel10k mmc

# Initialize completions.
autoload -Uz compstyleinit && compstyleinit
compstyle zshzoo
fpath+=($ZSH_CONFIG_DIR/completions(N))
autoload -Uz compinit
ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump
compinit -d "$ZSH_COMPDUMP"

# Never start an interactive session in the root file system.
[[ "$PWD" != "/" ]] || cd

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
unset ZPROFRC

# Always return success.
true

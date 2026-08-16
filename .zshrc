#!/usr/bin/env zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set the styles
[[ -r $ZDOTDIR/.zstyles ]] \
 && . $ZDOTDIR/.zstyles

# Create an amazing Zsh config using antidote plugins.
fpath+=($ZDOTDIR/functions $fpath)
autoload -Uz is-macos
zsh_theme=(starship zephyr)
source $ZDOTDIR/lib/antidote-edge.zsh

# Never start in the root file system.
[[ "$PWD" != "/" ]] || cd

# we skip these for z1
source $ZDOTDIR/lib/compinit.zsh
source $ZDOTDIR/lib/confd.zsh

# Local settings
[[ -r $HOME/.local/config/zsh/.zshrc.local ]] \
 && . $HOME/.local/config/zsh/.zshrc.local

# Run the end of zshrc hook manually (defined in Z1)
run_post_zshrc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true

#!/usr/bin/env zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Show the starship prompt instantly with starship-ftl
path=(/opt/homebrew/bin(N) $path)
setopt transient_rprompt
zstyle ':ftl-prompt:' cursor bar

# # Lazy-load (autoload) Zsh function files from a directory.
# fpath=($ZDOTDIR/functions $fpath)
# autoload -Uz $ZDOTDIR/functions/*(.:t)

# FTL testing
# first, comment this out in .zsh_plugins.txt:
#   mattmc3/starship-ftl post:'ftl-prompt starship zsh; ftl-transient on'
# source $ZDOTDIR/lib/test-ftl.zsh
# # test-ftl
# test-no-ftl

# Create an amazing Zsh config using antidote plugins.
source $ZDOTDIR/lib/antidote-fast.zsh

# Never start in the root file system.
[[ "$PWD" != "/" ]] || cd

# Local settings
[ -r $HOME/.local/config/zsh/.zshrc.local ] \
&& . $HOME/.local/config/zsh/.zshrc.local

# Run the end of zshrc hook manually
run_post_zshrc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true

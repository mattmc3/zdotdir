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

# FTL testing
# first, comment this out in .zsh_plugins.txt:
#   mattmc3/starship-ftl post:'ftl-prompt starship zsh; ftl-transient on'
# source $HOME/Projects/mattmc3/starship-ftl/starship-ftl.plugin.zsh
# ftl-prompt starship zsh
# ftl-transient on
# test-no-ftl

# Create an amazing Zsh config using antidote plugins.
is-macos() { [[ "$OSTYPE" == darwin* ]]; }
source $ZDOTDIR/lib/antidote-fast.zsh

# Never start in the root file system.
[[ "$PWD" != "/" ]] || cd

# Source conf.d files
local -a _zrcs=($ZDOTDIR/conf.d/*.{z,}sh(N-.))
for _zrc in ${(o)_zrcs}; do
  [[ "${_zrc:t}" == '~'* ]] || source "$_zrc"
done
unset _zrc{,s}

# Local settings
[ -r $HOME/.local/config/zsh/.zshrc.local ] \
&& . $HOME/.local/config/zsh/.zshrc.local

# Run the end of zshrc hook manually (defined in Z1)
run_post_zshrc

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

# Always return success
true

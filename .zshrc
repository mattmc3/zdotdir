#!/bin/zsh
#
# zprof
#

# Load zprof first if we need to profile.
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

#
# Essentials
#

# Don't trust plugin managers to load this because if my .zshrc breaks after this, I'd
# like at least this much to work.
[[ -f $ZDOTDIR/plugins/essentials/essentials.plugin.zsh ]] && . $ZDOTDIR/plugins/essentials/essentials.plugin.zsh


#
# zstyles
#

[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles


test -f /usr/bin/keychain && eval $(/usr/bin/keychain --eval --quiet id_ed25519)

#
# antidote
#

ANTIDOTE_HOME=$ZDOTDIR/plugins/.external

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zplugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote/functions)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]] || [[ ! -s $zsh_plugins ]]; then
  source $ZDOTDIR/.antidote/antidote.zsh
  #(antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
  (envsubst <${zsh_plugins:r}.txt | antidote bundle >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins


#
# Local
#

# Local settings/overrides
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local


#
# Wrap up
#

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

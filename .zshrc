#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Lazy-load (autoload) Zsh function files from a directory.
# fpath=($ZDOTDIR/functions $fpath)
# autoload -Uz $ZDOTDIR/functions/*(.:t)

# Create an amazing Zsh config using antidote plugins.
if [[ ! -d $ZDOTDIR/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote $ZDOTDIR/.antidote
fi
source $ZDOTDIR/.antidote/antidote.zsh
source <(antidote init)

# Pins
OMZ_SHA=7ea697fd8138550ddf7262456d412f0dcd1cbf84 # 2026-07-29

# Show an instant prompt
antidote bundle mattmc3/z1
setopt transient_rprompt
source $ZDOTDIR/lib/rapid-prompt.zsh
rapid_prompt z1

antidote bundle <<EOBUNDLES
  # Better Zsh defaults
  # mattmc3/z1
  mattmc3/use-xdg-basedirs

  # Utils
  mattmc3/zman

  # OMZ plugins
  using:ohmyzsh/ohmyzsh path:plugins pin:$OMZ_SHA
  magic-enter
  fancy-ctrl-z
  extract

  # romkatv/powerlevel10k
  romkatv/zsh-bench kind:path
  romkatv/zsh-no-ps2

  # Fishy
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions kind:fpath path:src
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search post:bindkey-hss
EOBUNDLES

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

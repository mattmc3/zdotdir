#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zstyles
[[ -f $ZDOTDIR/.zstyles ]] && . $ZDOTDIR/.zstyles

# Lazy-load functions directory like fish.
autoload -Uz $ZDOTDIR/functions/autoload-dir
autoload-dir $ZDOTDIR/functions $ZDOTDIR/functions/*(/FN)

# Add custom completions directory like fish.
fpath=($ZDOTDIR/completions(/N) $fpath)

# Set history vars.
HISTFILE=$XDG_DATA_HOME/zsh/history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
SAVEHIST=10000
HISTSIZE=10000

# add conf.d like fish
for zfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  [[ $zfile:t != '~'* ]] || continue
  . $zfile
done
unset zfile

# Load starship prompt.
export STARSHIP_CONFIG=$ZDOTDIR/themes/mmc.toml
eval "$(starship init zsh)"

# Load local overrides.
[[ -f $DOTFILES/local/zsh/zshrc_local.zsh ]] && . $DOTFILES/local/zsh/zshrc_local.zsh

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

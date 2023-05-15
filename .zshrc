#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

[[ -f $ZDOTDIR/.zstyles ]] && . $ZDOTDIR/.zstyles
[[ -f $ZDOTDIR/.zvars ]] && . $ZDOTDIR/.zvars
[[ -f $ZDOTDIR/.zaliases ]] && . $ZDOTDIR/.zaliases

# Lazy-load functions directory like fish.
autoload -Uz $ZDOTDIR/functions/autoload-dir
autoload-dir $ZDOTDIR/functions $ZDOTDIR/functions/*(/FN)

# Add custom completions directory like fish.
fpath=($ZDOTDIR/completions(/N) $fpath)

# Load antidote for plugin management.
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
zplugins=${ZDOTDIR:-$HOME}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]]; then
  (antidote bundle <${zplugins} >${zplugins}.zsh)
fi
source ${zplugins}.zsh

# Add conf.d like fish.
for zfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  [[ $zfile:t != '~'* ]] || continue
  . $zfile
done
unset zfile

# Load local overrides.
if [[ ! -f $ZDOTDIR/.zlocal ]] && [[ -f $DOTFILES/local/zsh/zshrc_local.zsh ]]; then
  ln -sf $DOTFILES/local/zsh/zshrc_local.zsh $ZDOTDIR/.zlocal
fi
[[ -f $ZDOTDIR/.zlocal ]] && . $ZDOTDIR/.zlocal

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

# vim: ft=zsh sw=2 ts=2 et

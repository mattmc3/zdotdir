#
# .zshrc - Run on interactive Zsh session.
#

# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Essential zsh options
setopt extended_glob no_beep

# Lazy-load functions directory like fish.
for fndir in $ZDOTDIR/functions(/FN) $ZDOTDIR/functions/*(/FN); do
  fpath=($fndir $fpath)
  autoload -Uz $fpath[1]/*~*/_*(N.:t)
done

# Add custom completions directory like fish.
fpath=($ZDOTDIR/completions(/N) $fpath)

# Setup history.
HISTFILE=$XDG_DATA_HOME/zsh/zsh_history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
SAVEHIST=10000
HISTSIZE=10000

# Add conf.d like fish.
for zfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  [[ $zfile:t != '~'* ]] || continue
  . $zfile
done

# Load local overrides.
[[ -f $ZDOTDIR/.zlocal ]] && . $ZDOTDIR/.zlocal

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof

# Cleanup
unset ZPROFRC zfile fndir
true

# vim: ft=zsh sw=2 ts=2 et

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# drive config with antidote
ANTIDOTE_HOME=$ZDOTDIR/.antidote/.plugins
zstyle ':antidote:bundle' use-friendly-names 'yes'

# load antidote
if [[ ! $ZDOTDIR/.zplugins.zsh -nt $ZDOTDIR/.zplugins ]]; then
  [[ -e $ZDOTDIR/.antidote ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote
  (
    source $ZDOTDIR/.antidote/antidote.zsh
    antidote bundle <$ZDOTDIR/.zplugins >$ZDOTDIR/.zplugins.zsh
  )
fi
source $ZDOTDIR/.zplugins.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

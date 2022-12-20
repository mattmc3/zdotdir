#
# Executes commands at the start of an interactive session.
#

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# autoload functions
export ZFUNCDIR=${ZDOTDIR:-~/.config/zsh}/functions
fpath=($fpath $ZFUNCDIR(/N))
for _fnfile in $ZFUNCDIR/*(.N); do
  autoload -Uz "${_fnfile:t}"
done
unset _fnfile

# drive config with antidote
ANTIDOTE_HOME=$ZDOTDIR/plugins/.external
ANTIDOTE_DIR=$ZDOTDIR/.antidote
#ANTIDOTE_DIR=~/Projects/mattmc3/antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file $ZDOTDIR/.zplugins.txt

# load antidote
if [[ ! $ZDOTDIR/.zplugins.zsh -nt $ZDOTDIR/.zplugins ]]; then
  [[ -e $ANTIDOTE_DIR ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
  (
    source $ANTIDOTE_DIR/antidote.zsh
    envsubst <$ZDOTDIR/.zplugins | antidote bundle >$ZDOTDIR/.zplugins.zsh
  )
fi
autoload -Uz $ANTIDOTE_DIR/functions/antidote
source $ZDOTDIR/.zplugins.zsh

### conf.d
for _confd in "$ZDOTDIR"/conf.d/*.zsh(N); do
  [[ ${_confd:t} != '~'* ]] || continue
  source "$_confd"
done
unset _confd

bindkey -e  # emacs
source $ZDOTDIR/.zaliases

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

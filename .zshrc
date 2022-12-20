#
# Executes commands at the start of an interactive session.
#

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# core
source $ZDOTDIR/lib/zfunctions.zsh
source $ZDOTDIR/lib/directory.zsh
source $ZDOTDIR/lib/editor.zsh
source $ZDOTDIR/lib/environment.zsh
source $ZDOTDIR/lib/history.zsh

# use antidote for plugins
ANTIDOTE_HOME=$ZDOTDIR/.plugins
ANTIDOTE_DIR=$ZDOTDIR/.antidote
#ANTIDOTE_DIR=~/Projects/mattmc3/antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file $ZDOTDIR/.zplugins

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

# conf.d
source $ZDOTDIR/lib/confd.zsh

# prompt
source $ZDOTDIR/lib/prompt.zsh

# aliases
source $ZDOTDIR/.zaliases

# completions
source $ZDOTDIR/lib/completion.zsh

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

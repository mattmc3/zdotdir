#
# Handle plugins using antidote.
#

ANTIDOTE_HOME=$ZDOTDIR/.antidote/.plugins
ANTIDOTE_DIR=$ZDOTDIR/.antidote
#ANTIDOTE_DIR=~/Projects/mattmc3/antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file $ZDOTDIR/lib/zsh_plugins.txt

# load antidote
if [[ ! $ZDOTDIR/.zplugins.zsh -nt $ZDOTDIR/lib/zsh_plugins.txt ]]; then
  [[ -e $ANTIDOTE_DIR ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
  (
    source $ANTIDOTE_DIR/antidote.zsh
    envsubst <$ZDOTDIR/lib/zsh_plugins.txt | antidote bundle >$ZDOTDIR/.zplugins.zsh
  )
fi
autoload -Uz $ANTIDOTE_DIR/functions/antidote
source $ZDOTDIR/.zplugins.zsh

# plugin settings
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/lib/abbr.zsh

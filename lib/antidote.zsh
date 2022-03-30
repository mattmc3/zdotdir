# antidote config
ANTIDOTE_HOME=${ZDOTDIR:-~}/.plugins
zstyle ':antidote:bundle' use-friendly-names 'yes'

# load antidote
if [[ ! $ZDOTDIR/.zsh_plugins.zsh -nt $ZDOTDIR/.zsh_plugins.txt ]]; then
  [[ -e $ZDOTDIR/.antidote ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote
  (
    source $ZDOTDIR/.antidote/antidote.zsh
    function _antidote_friendlyname {
      echo $(antidote home)/${${1%.git}:t}
    }
    antidote bundle <$ZDOTDIR/.zsh_plugins.txt >$ZDOTDIR/.zsh_plugins.zsh
  )
fi
source $ZDOTDIR/.zsh_plugins.zsh

#
# Load plugins.
#

ZPLUGINDIR=$ZDOTDIR/plugins
ZSH_PROMPT=powerlevel10k

plugins=(
  # essential
  directory
  editor
  history
  prompt
  utility

  # plugins
  autosuggestions
  extract
  fancy-ctrl-z
  macos
  magic-enter
  python
  string
  z

  # load last
  abbreviations
  zopts
  completion
  syntax-highlighting
  history-substring-search
)

for _p in $plugins; do
  source $ZPLUGINDIR/${_p}/${_p}.plugin.zsh
done
unset _p

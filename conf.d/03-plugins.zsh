#
# Load plugins.
#

ZPLUGINDIR=$ZDOTDIR/plugins
ZSH_PROMPT=powerlevel10k

plugins=(
  abbreviations
  autosuggestions
  directory
  editor
  extract
  fancy-ctrl-z
  history
  macos
  magic-enter
  prompt
  python
  string
  utility
  z

  # load last
  zopts
  completion
  syntax-highlighting
  history-substring-search
)

for _p in $plugins; do
  source $ZPLUGINDIR/${_p}/${_p}.plugin.zsh
done
unset _p

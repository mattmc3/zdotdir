#
# Load plugins.
#

ZPLUGINDIR=$ZDOTDIR/plugins
ZSH_PROMPT=pure

plugins=(
  abbreviations
  autosuggestions
  colored-man-pages
  directory
  editor
  extract
  fancy-ctrl-z
  history
  magic-enter
  prompt
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

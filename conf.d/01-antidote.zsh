# Load antidote for plugin management.
source ${HOMEBREW_PREFIX:=/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
zplugins=${ZDOTDIR:-$HOME}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]]; then
  (antidote bundle <${zplugins} >${zplugins}.zsh)
fi
source ${zplugins}.zsh

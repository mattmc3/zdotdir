# Load antidote for plugin management.
zplugins=${ZDOTDIR:-$HOME}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]]; then
  (
    source ${HOMEBREW_PREFIX:=/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
    antidote bundle <${zplugins} >${zplugins}.zsh
  )
fi
source ${zplugins}.zsh

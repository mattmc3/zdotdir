#
# .zshrc - Run on interactive Zsh session.
#

# init profiling
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zstyles
[[ -r $ZDOTDIR/.zstyles ]] && . $ZDOTDIR/.zstyles

# use antidote for plugin management
zplugins=${ZDOTDIR:-$HOME}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]]; then
  (
    source ${HOMEBREW_PREFIX:=/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
    antidote bundle <${zplugins} >${zplugins}.zsh
  )
fi
source ${zplugins}.zsh

# prompt
setopt prompt_subst
prompt starship zephyr

# done profiling
[[ -z "$ZPROFRC" ]] || zprof

# cleanup
unset ZPROFRC zplugins
true

# vim: ft=zsh sw=2 ts=2 et

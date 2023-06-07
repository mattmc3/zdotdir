#
# .zshrc - Run on interactive Zsh session.
#

# init profiling
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zstyles
[[ -r $ZDOTDIR/.zstyles ]] && . $ZDOTDIR/.zstyles

# use antidote for plugin management
export ANTIDOTE_HOME=${XDG_CACHE_HOME:=~/.cache}/repos
[[ -d $ANTIDOTE_HOME/mattmc3/antidote ]] ||
  git clone --depth 1 --quiet https://github.com/mattmc3/antidote $ANTIDOTE_HOME/mattmc3/antidote

# keep all 3 for different test scenarios
# . $ANTIDOTE_HOME/mattmc3/antidote/antidote.zsh
# . ~/Projects/mattmc3/antidote/antidote.zsh
# . ${HOMEBREW_PREFIX:=/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
source $ANTIDOTE_HOME/mattmc3/antidote/antidote.zsh
antidote load

# prompt
prompt starship mmc

# done profiling
[[ -z "$ZPROFRC" ]] || zprof

# cleanup
unset ZPROFRC zplugins
true

# vim: ft=zsh sw=2 ts=2 et

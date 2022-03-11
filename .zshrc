# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# antidote config
# ANTIDOTE_HOME=${ZDOTDIR:-~}/.antidote/.cache
# zstyle ':antidote:bundle' use-friendly-names 'yes'

# clone antidote if necessary and generate a static plugin file
[[ -e ${ZDOTDIR:-~}/.antidote ]] || \
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
#source ~/Projects/mattmc3/antidote/antidote.zsh
antidote load

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

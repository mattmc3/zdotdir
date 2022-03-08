# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# clone antidote if necessary and generate a static plugin file
zhome=${ZDOTDIR:-$HOME}
if [[ ! $zhome/.zsh_plugins.zsh -nt $zhome/.zsh_plugins.txt ]]; then
  [[ -e $zhome/.antidote ]]        || git clone --depth=1 https://github.com/mattmc3/antidote.git $zhome/.antidote
  [[ -e $zhome/.zsh_plugins.txt ]] || touch $zhome/.zsh_plugins.txt
  (
    source $zhome/.antidote/antidote.zsh
    antidote bundle <$zhome/.zsh_plugins.txt >$zhome/.zsh_plugins.zsh
  )
fi
source $zhome/.zsh_plugins.zsh
unset zhome

# # antidote plugin manager
# if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
#   git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote
#   [[ -f ${ZDOTDIR:-~}/.zsh_plugins.zsh ]] && rm ${ZDOTDIR:-~}/.zsh_plugins.zsh
# fi
# source ~/Projects/mattmc3/antidote/antidote.zsh
# #source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# # antidote config
# # ANTIDOTE_HOME=${ZDOTDIR:-~}/.antidote/.cache
# # zstyle ':antidote:bundle' use-friendly-names 'yes'

# # antidote dynamic
# # source <(antidote init)
# # antidote bundle < ${ZDOTDIR:-~}/.zsh_plugins.txt

# # antidote static
# if [[ ! -f ${ZDOTDIR:-~}/.zsh_plugins.zsh ]]; then
#   antidote bundle < ${ZDOTDIR:-~}/.zsh_plugins.txt > ${ZDOTDIR:-~}/.zsh_plugins.zsh
# fi
# source ${ZDOTDIR:-~}/.zsh_plugins.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

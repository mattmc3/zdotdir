# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

[[ -d ${ZDOTDIR:-~}/.zephyr ]] ||
  git clone https://github.com/zshzoo/zephyr ${ZDOTDIR:-~}/.zephyr

source ${ZDOTDIR:-~}/.zephyr/zephyr.zsh
#source ~/Projects/zshzoo/zephyr/zephyr.zsh
zephyr init
#prompt pure

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

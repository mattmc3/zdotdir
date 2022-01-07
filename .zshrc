# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# drive config with plugins
ZPLUGINDIR=${ZDOTDIR:-~}/.zplugins
if [[ ! -f $ZPLUGINDIR/init.zsh ]]; then
  mkdir -p $ZPLUGINDIR
  envsubst < ${ZDOTDIR:-~}/.zsh_plugins.txt | plugin-bundle >| $ZPLUGINDIR/init.zsh
fi
source $ZPLUGINDIR/init.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

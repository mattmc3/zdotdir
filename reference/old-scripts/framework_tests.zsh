# zbenchmark
alias zbench="for i in \$(seq 1 10); do; /usr/bin/time zsh -i -c exit; done"

source $ZDOTDIR/.zgen/zgen.zsh

# OMZ: a basic config takes 0.12 - 0.13 via zbench
zgen clone robbyrussell/oh-my-zsh-master
ZSH=$ZDOTDIR/.zgen/robbyrussell/oh-my-zsh-master
plugins=(git)
ZSH_CUSTOM=$ZDOTDIR/zsh_custom
source "$ZSH/oh-my-zsh.sh"

# Prezto: a basic config takes 0.08 via zbench
zgen clone sorin-ionescu/prezto
source "${ZDOTDIR}/.zgen/sorin-ionescu/prezto-master/init.zsh"

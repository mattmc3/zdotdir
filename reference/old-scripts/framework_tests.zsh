# OMZ: a basic config takes 0.12 - 0.13 via zbenchmark
ZSH=$ZDOTDIR/plugins/oh-my-zsh
plugins=(git)
ZSH_CUSTOM=$ZDOTDIR/zsh_custom
source "$ZSH/oh-my-zsh.sh"


# Prezto: a basic config takes 0.08 via zbenchmark
source "${ZDOTDIR}/plugins/prezto/init.zsh"


# zbenchmark
# for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done

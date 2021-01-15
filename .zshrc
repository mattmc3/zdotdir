# zprof if we ever need to profile
alias runzprof="ZPROF=true zsh"
[[ $ZPROF != true ]] || zmodload zsh/zprof
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'

# zlib pre
source $ZDOTDIR/zlib/environment.zsh
source $ZDOTDIR/zlib/pre-plugins.zsh

source $ZDOTDIR/zlib/pz.zsh

# zlib post
source $ZDOTDIR/zlib/post-plugins.zsh
source $ZDOTDIR/zlib/local.zsh

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

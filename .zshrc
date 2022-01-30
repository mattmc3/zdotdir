# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# add completions, functions, and conf.d dirs like fish
fpath+=$ZDOTDIR/completions
ZFUNCDIR=$ZDOTDIR/functions
fpath+="$ZFUNCDIR"
for f in $ZFUNCDIR/**/*(.N);        do autoload -Uz $f; done
for f in $ZDOTDIR/zshrc.d/*.zsh(N); do source "$f";     done
unset f

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

# zprof if we ever need to profile
alias runzprof="ZPROF=true zsh"
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'
[[ $ZPROF != true ]] || zmodload zsh/zprof

# use functions directory for zsh functions
fpath=("$ZDOTDIR"/functions $fpath)
for _fn in "$ZDOTDIR"/functions/*(.N); do
  autoload -Uz "$_fn"
done
unset _fn

# use zshrc.d directory for config
for _f in "$ZDOTDIR"/zshrc.d/*.{sh,zsh}(.N); do
  # ignore files that begin with a tilde
  case $_f:t in ~*) continue;; esac
  source "$_f"
done
unset _f

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

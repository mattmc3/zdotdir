# zprof if we ever need to profile
alias runzprof="ZPROF=true zsh"
[[ $ZPROF != true ]] || zmodload zsh/zprof

# use zshrc.d directory for config
for _f in "$ZDOTDIR"/zshrc.d/*.{sh,zsh}(.N); do
  # ignore files that begin with a tilde
  case $_f:t in ~*) continue;; esac
  source "$_f"
done
unset _f

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

# https://htr3n.github.io/2018/07/faster-zsh/
# uncomment for profiling, then run zprof after zsh loads
# zmodload zsh/zprof

for file in $ZDOTDIR/conf.d/*.{sh,zsh}(N); do
  case $file:t in ~*) continue;; esac
  source "$file"
done

[[ -f "$ZDOTDIR"/.zshrc.local ]] && . "$ZDOTDIR"/.zshrc.local

true  # make sure exit code is happy

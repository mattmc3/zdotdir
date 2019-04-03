for file in $ZDOTDIR/conf.d/*.{sh,zsh}(N); do
  case $file:t in ~*) continue;; esac
  source "$file"
done

[[ -f "$ZDOTDIR"/.shellrc.local ]] && . "$ZDOTDIR"/.shellrc.local

true  # make exit code happy

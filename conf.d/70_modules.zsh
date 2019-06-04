for file in $ZDOTDIR/modules/*.{sh,zsh}(N); do
  case $file:t in ~*) continue;; esac
  source "$file"
done

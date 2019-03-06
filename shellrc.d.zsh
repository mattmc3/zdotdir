for file in "${0:A:h}"/shellrc.d/*.{sh,zsh}(N); do
  case $file:t in ~*) continue;; esac
  source "$file"
done

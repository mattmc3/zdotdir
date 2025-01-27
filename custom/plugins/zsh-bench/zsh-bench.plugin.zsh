repodir="$ZSH_CUSTOM/.external/zsh-bench"
if [[ ! -d "$repodir" ]]; then
  git clone --quiet --depth 1 https://github.com/romkatv/zsh-bench "$repodir"
fi
path+=($repodir)
unset repodir

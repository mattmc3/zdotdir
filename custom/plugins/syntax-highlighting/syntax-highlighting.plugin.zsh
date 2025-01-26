repodir="$ZSH_CUSTOM/.external/fast-syntax-highlighting"
if [[ ! -d "$repodir" ]]; then
  git clone --quiet --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting "$repodir"
fi
source $repodir/fast-syntax-highlighting.plugin.zsh
unset repodir

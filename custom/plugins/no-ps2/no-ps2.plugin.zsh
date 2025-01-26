repodir="$ZSH_CUSTOM/.external/zsh-no-ps2"
if [[ ! -d "$repodir" ]]; then
  git clone --quiet --depth 1 https://github.com/romkatv/zsh-no-ps2 "$repodir"
fi
source $repodir/zsh-no-ps2.plugin.zsh
unset repodir

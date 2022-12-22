#
# Initialize Zsh for remaining config.
#

#region Plugin functions

function plugin-clone {
  # https://github.com/mattmc3/zsh_unplugged
  emulate -L zsh; setopt local_options extended_glob no_monitor
  local repo destdir initfile
  local zhome=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}
  local plugext=$zhome/plugins/.external

  for repo in ${(u)@}; do
    destdir=$plugext/${repo:t}
    initfile=$destdir/${repo:t}.plugin.zsh

    if [[ ! -d $destdir ]]; then
      echo "Cloning $repo..."
      () {
        git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $destdir
        if [[ ! -e $initfile ]]; then
          local -a initfiles=($destdir/*.plugin.{z,}sh(N) $destdir/*.{z,}sh{-theme,}(N))
          (( $#initfiles )) && ln -sf "${initfiles[1]}" "$initfile"
        fi
      } &
    fi
  done
  wait
}

#endregion

#region Clone

_repos=(
  belak/zsh-utils
  mattmc3/zman
  ohmyzsh/ohmyzsh
  olets/zsh-abbr
  olets/zsh-window-title
  romkatv/powerlevel10k
  romkatv/zsh-bench
  romkatv/zsh-defer
  rupa/z
  sindresorhus/pure
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
)
plugin-clone $_repos
unset _repos

#endregion

#region Git

_gitdir=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}/plugins/.external/git
if [[ ! -d $_gitdir ]]; then
  mkdir -p $_gitdir

  # Download the latest git completion scripts
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $_gitdir/git-completion.bash
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh $_gitdir/_git
fi

#endregion

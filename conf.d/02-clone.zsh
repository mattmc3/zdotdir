#
# Initialize Zsh for remaining config.
#

#region Clone

ZPLUGINDIR=$ZDOTDIR/plugins/.external
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

# https://www.oliverspryn.com/blog/adding-git-completion-to-zsh

_gitdir=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}/plugins/.external/git
if [[ ! -d $_gitdir ]]; then
  mkdir -p $_gitdir

  # Download the latest git completion scripts
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $_gitdir/git-completion.bash
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o $_gitdir/_git
fi

#endregion

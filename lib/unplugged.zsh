#
# Handle plugins using zsh_unplugged.
#

export ZPLUGINDIR=${ZDOTDIR:-~}/.unplugged

#region: clone plugins
repos=(
  # core
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  zdharma-continuum/fast-syntax-highlighting
  romkatv/zsh-defer

  # prompts
  sindresorhus/pure

  # regular plugins
  mattmc3/zman
  mattmc3/zsh-safe-rm
  olets/zsh-abbr
  olets/zsh-window-title
  rupa/z

  # utilities
  romkatv/zsh-bench

  # frameworks
  ohmyzsh/ohmyzsh
  # sorin-ionescu/prezto
)
plugin-clone $repos
#endregion

#region: load non-standard plugins
# config romkatv/zsh-bench
path+=("$ZPLUGINDIR/zsh-bench")
fpath+=("$ZPLUGINDIR/zsh-completions/src")
fpath+=("$ZPLUGINDIR/pure")
#endregion

#region: source plugins
plugins=(
  # core
  zsh-completions

  # plugins
  zman
  zsh-safe-rm
  z

  # framework plugins
  ohmyzsh/plugins/extract
  ohmyzsh/plugins/fancy-ctrl-z
  ohmyzsh/plugins/magic-enter

  # load last
  zsh-history-substring-search
  zsh-autosuggestions

  # defers
  zsh-defer
  zsh-abbr
  fast-syntax-highlighting
)
plugin-source $plugins
#endregion

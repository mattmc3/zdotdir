ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-~/.config/zsh}/plugins}

# make a github repo plugins list
plugins=(
  # load these first
  sindresorhus/pure
  romkatv/zsh-defer

  # zshzoo plugins
  zshzoo/setopts
  zshzoo/history
  zshzoo/keybindings
  zshzoo/zstyle-completions
  zshzoo/copier
  zshzoo/macos
  zshzoo/prj
  zshzoo/magic-enter
  zshzoo/zfishcmds
  zshzoo/termtitle

  # 3rd party
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  mattmc3/zman
  olets/zsh-abbr
  rupa/z
  rummik/zsh-tailf
  peterhurford/up.zsh

  # load these last
  zshzoo/compinit
  zdharma-continuum/fast-syntax-highlighting
)
plugin-load $plugins

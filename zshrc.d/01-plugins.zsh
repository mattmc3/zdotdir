ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-~/.config/zsh}/plugins}

# make a github repo plugins list
plugins=(
  # load these first
  sindresorhus/pure
  romkatv/zsh-defer

  # frameworks
  sorin-ionescu/prezto
  ohmyzsh/ohmyzsh

  # plugins when not using prezto
  # zshzoo/setopts
  # zshzoo/history
  # zshzoo/keybindings
  # zshzoo/zstyle-completions
  # zshzoo/copier
  # zshzoo/macos
  # zshzoo/magic-enter
  # zshzoo/termtitle
  # zsh-users/zsh-autosuggestions
  # zsh-users/zsh-history-substring-search

  # 3rd party
  zshzoo/prj
  zshzoo/copier
  mattmc3/zman
  olets/zsh-abbr
  rupa/z
  # rummik/zsh-tailf
  # peterhurford/up.zsh

  # repo-only plugins
  romkatv/zsh-bench
  mbadolato/iTerm2-Color-Schemes

  # load these last
  zshzoo/compinit
  zdharma-continuum/fast-syntax-highlighting
)
plugin-clone $plugins

# uncomment to source plugins manually, otherwise, use prezto to source them
# plugin-source $plugins

# do some manual stuff that prezto won't handle
fpath+=$ZPLUGINDIR/pure
path+=$ZPLUGINDIR/zsh-bench
source $ZPLUGINDIR/zsh-defer/init.zsh
zsh-defer source $ZPLUGINDIR/zsh-abbr/init.zsh

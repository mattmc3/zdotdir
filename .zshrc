# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# clone a plugins and identify their init files
# let prezto source it
function contrib-clone() {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/init.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] && ln -sf "${initfiles[1]}" "$initfile"
    fi
  done
}

# call our plugins dir contribs like prezto does
ZPLUGINDIR=${ZDOTDIR:-~}/.zcontribs

contribs=(
  # prezto
  sorin-ionescu/prezto
  belak/prezto-contrib
  mattmc3/my-prezto-contrib

  # 3rd party contribs
  joshskidmore/zsh-fzf-history-search
  mattmc3/zman
  rupa/z
  zdharma-continuum/fast-syntax-highlighting

  # archive
  # peterhurford/up.zsh
  # rummik/zsh-tailf
)
contrib-clone $contribs

omz_plugins=(
  extract
  lib/clipboard
  copydir
  copybuffer
  copyfile
  macos
  magic-enter
)

prezto_modules=(
  # do these first
  init

  # zprezto built-ins
  environment
  terminal
  editor
  history
  directory
  spectrum
  utility
  history-substring-search
  prompt
  autosuggestions
  git

  # belak/prezto-contrib
  clipboard
  elapsed-time

  # my zprezto-contribs
  xdg-basedirs
  abbreviations
  aliases
  colored-man-pages
  curl
  dotfiles
  emacs
  git
  golang
  gpg
  groovy
  homebrew
  iwd
  java
  jupyter
  less
  lpass
  macos
  node
  nuget
  prj
  python
  readline
  ruby
  rust
  shell-safe-rm
  string
  tmux
  todo-txt
  wget
  zfunctions
  zsh-bench
  zopts

  # 3rd party contribs
  zsh-fzf-history-search
  z
  zman

  # load these last
  completion
  ohmyzsh
  fast-syntax-highlighting
)

# this can go in .zpreztorc, or in .zshrc if you don't want an extra file
# for prezto configs
zstyle ':prezto:load' pmodule $prezto_modules
zstyle ':prezto:load' pmodule-dirs $ZPLUGINDIR $ZPLUGINDIR/prezto-contrib $ZPLUGINDIR/my-prezto-contrib
zstyle ':prezto:load' pmodule-allow-overrides 'yes'
zstyle ':prezto:module:prompt' theme 'pure'
zstyle ':prezto:module:git:alias' skip 'yes'
zstyle ':prezto:module:utility' correct 'no'
zstyle ':omz:load' plugins $omz_plugins

# source prezto and let it load contribs we cloned as modules
ZPREZTODIR=$ZPLUGINDIR/prezto
source $ZPREZTODIR/init.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

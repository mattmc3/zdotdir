# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

omz_plugins=(
  extract
  lib/clipboard
  copydir
  copybuffer
  copyfile
  macos
  magic-enter
  z
)

prezto_modules=(
  # do these first
  _init

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
  emacs
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
  fzf-history-search
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

  # load these last
  completion
  ohmyzsh
  fast-syntax-highlighting
)

# setup prezto and tell it about our contribs
ZPREZTODIR=$ZDOTDIR/.zprezto
declare -A repos
repos=(
  https://github.com/sorin-ionescu/prezto $ZDOTDIR/.zprezto
  https://github.com/belak/prezto-contrib $ZDOTDIR/.zprezto-contribs
  git@github.com:mattmc3/prezto-chango    $ZDOTDIR/.zcontribs-custom
)
for repo dirname in ${(kv)repos}; do
  if [[ ! -d $dirname ]]; then
    git clone --depth 1 --quiet --recurse-submodules --shallow-submodules \
    $repo $dirname
  fi
done
unset repo dirname repos

# this can go in .zpreztorc, or in .zshrc if you don't want an extra file
# for prezto configs
zstyle ':prezto:load' pmodule $prezto_modules
zstyle ':prezto:load' pmodule-dirs $ZDOTDIR/.zprezto-contribs $ZDOTDIR/.zcontribs-custom
zstyle ':prezto:load' pmodule-allow-overrides 'yes'
zstyle ':prezto:module:prompt' theme 'pure'
zstyle ':prezto:module:git:alias' skip 'yes'
zstyle ':prezto:module:utility' correct 'no'
zstyle ':omz:load' plugins $omz_plugins
source $ZPREZTODIR/init.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

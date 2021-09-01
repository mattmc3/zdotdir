# zprof if we ever need to profile
alias runzprof="ZPROF=true zsh"
[[ $ZPROF != true ]] || zmodload zsh/zprof
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'

# environment
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"
export VISUAL="code"
export DOTFILES="$HOME/.config/dotfiles"

# plugin variables
XDG_APPS=(
  docker
  docker-machine
  gnupg
  jupyter
  less
  nodejs
  npm
  readline
  screen
  tmux
  wget
  z
)
zstyle ':xdg-basedirs:*' apps $XDG_APPS
PURE_PROMPT_SYMBOL="%%"

# setup pz as our plugin manager
PZ_PLUGIN_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone --depth=1 --recursive https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh

pz source zshzoo/setopts
pz source zshzoo/history
pz source zshzoo/up
pz source zshzoo/iwd
pz source rummik/zsh-tailf
pz source ohmyzsh/ohmyzsh lib/functions
pz source ohmyzsh/ohmyzsh lib/termsupport
#pz source ohmyzsh/ohmyzsh lib/key-bindings
pz source ohmyzsh/ohmyzsh lib/clipboard
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages
pz source sorin-ionescu/prezto modules/editor
#pz source sorin-ionescu/prezto modules/terminal
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-completions
pz source mattmc3/zsh-xdg-basedirs
pz source mattmc3/zsh-cd-ls
pz source zsh-users/zsh-completions
pz source rupa/z
pz prompt sindresorhus/pure
pz source mattmc3/zshrc.d
pz source mattmc3/zfunctions
pz source zdharma/fast-syntax-highlighting
pz source zsh-users/zsh-history-substring-search

# funcs
for _d in $ZDOTDIR/functions/*/; do
  fpath=("$_d" $fpath)
  for _fn in "$_d"/*(.N); do
    autoload -Uz "$_fn"
  done
done
unset _d _fn

# local overrides
[[ -f $DOTFILES.local/zsh/zshrc.local.zsh ]] && . $DOTFILES.local/zsh/zshrc.local.zsh

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

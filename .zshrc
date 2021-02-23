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

pz source zshzoo/zebrafish
#source ~/Projects/zshzoo/zebrafish/zebrafish.zsh
pz source mattmc3/zsh-xdg-basedirs
pz source mattmc3/zsh-cd-ls
pz source zsh-users/zsh-completions
pz source rupa/z

# local overrides
[[ -f $DOTFILES/local/zsh/zshrc.local.zsh ]] && . $DOTFILES/local/zsh/zshrc.local.zsh

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }

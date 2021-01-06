# set variables for our various plugins prior to loading them

# mattmc3/zsh-xdg-basedirs - which apps do we want to use XDG base dirs
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

# sindresorhus/pure
PURE_PROMPT_SYMBOL="%%"

# ohmyzsh/ohmyzsh
export ZSH=$ZDOTDIR/plugins/ohmyzsh

# zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

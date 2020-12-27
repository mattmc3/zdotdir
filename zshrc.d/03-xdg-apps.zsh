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
)
zstyle ':xdg-basedirs:*' apps $XDG_APPS
zplugr source mattmc3/zsh-xdg-basedirs

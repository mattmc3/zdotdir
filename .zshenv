# ~/.zshenv only needs to source this file:
# echo "source \$HOME/.config/zsh/.zshenv" >| ~/.zshenv

export ZDOTDIR="$HOME/.config/zsh"
export ANTIBODY_HOME="$ZDOTDIR/zplugins"

# Set XDG dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.xdg

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR="$HOME/Desktop"
  export XDG_DOCUMENTS_DIR="$HOME/Documents"
  export XDG_DOWNLOAD_DIR="$HOME/Downloads"
  export XDG_MUSIC_DIR="$HOME/Music"
  export XDG_PICTURES_DIR="$HOME/Pictures"
  export XDG_VIDEOS_DIR="$HOME/Videos"
fi

export DOTFILES=$HOME/.dotfiles

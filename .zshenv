# ~/.zshenv should only be a one-liner that sources this file
# echo "export ZDOTDIR=~/.zsh; [ -f $ZDOTDIR/.zshenv ] && . $ZDOTDIR/.zshenv" >| ~/.zshenv

# set XDG dirs
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=~/.xdg

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=~/Desktop
  export XDG_DOCUMENTS_DIR=~/Documents
  export XDG_DOWNLOAD_DIR=~/Downloads
  export XDG_MUSIC_DIR=~/Music
  export XDG_PICTURES_DIR=~/Pictures
  export XDG_VIDEOS_DIR=~/Videos
fi

[[ -d ~/.config/dotfiles ]] && export DOTFILES=~/.config/dotfiles

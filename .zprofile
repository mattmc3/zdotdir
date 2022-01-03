[[ -f $ZDOTDIR/plugins/prezto/runcoms/zprofile ]] && . $ZDOTDIR/plugins/prezto/runcoms/zprofile

# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://wiki.archlinux.org/index.php/XDG_user_directories

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
  export XDG_PROJECTS_DIR=~/Projects
fi

export EDITOR='nvim'
export VISUAL='code'

export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

path=(
  ~/bin
  /usr/local/{bin,sbin}
  /opt/homebrew/{bin,sbin}
  $path
)
typeset -gU path

export SHELL_SESSIONS_DISABLE=1

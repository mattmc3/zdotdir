# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://wiki.archlinux.org/index.php/XDG_user_directories

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
fi

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Set the default Less options
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing)
# Remove -X to enable it
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export EDITOR='nvim'
export VISUAL='code'
export PAGER='less'

export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

path=(
  ~/bin
  ~/.config/zsh/bin
  /usr/local/{bin,sbin}
  /opt/homebrew/{bin,sbin}
  $path
)

# Set the list of directories that cd searches
# cdpath=(
#   $cdpath
# )

export SHELL_SESSIONS_DISABLE=1

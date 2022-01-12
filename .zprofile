# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://wiki.archlinux.org/index.php/XDG_user_directories

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

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

# My Zsh vars
export ZFUNCDIR=${ZFUNCDIR:-${ZDOTDIR:-$HOME/.config/zsh}/functions}
export ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-~}/.zplugins}

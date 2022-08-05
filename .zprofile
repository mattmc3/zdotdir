#
# .zprofile
#

export DOTFILES=~/.config/dotfiles

# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
  if [[ -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  else
    export HOMEBREW_PREFIX=/usr/local
  fi
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

# use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

path=(
  ~/bin(N)
  $HOMEBREW_PREFIX/{bin,sbin}(N)
  /usr/local/{bin,sbin}(N)
  ~/.emacs.d/bin(N)
  ~/.config/emacs/bin(N)
  $HOMEBREW_PREFIX/opt/curl/bin(N)
  $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/3.1.0/bin(N)
  ~/.gem/ruby/3.1.0/bin(N)
  $HOMEBREW_PREFIX/share/npm/bin(N)
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

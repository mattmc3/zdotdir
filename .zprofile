#
# .zprofile - execute login commands pre-zshrc
#
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

#
# XDG
#

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

# Ensure XDG dirs exist.
for xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
  [[ -e ${(P)xdgdir} ]] || mkdir -p ${(P)xdgdir}
done

# OS specific
if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
fi

#
# Common
#

# Set editor variables.
export EDITOR=vim
export VISUAL=code
export PAGER=less

# Browser.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Regional settings
export LANG='en_US.UTF-8'

# Ensure path arrays do not contain duplicates.
typeset -gU fpath path cdpath

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR
  $XDG_PROJECTS_DIR/mattmc3(N/)
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)

  # emacs
  $HOME/.emacs.d/bin(N)
  ${XDG_CONFIG_HOME:-$HOME/.config}/emacs/bin(N)

  # path
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Misc
#

export DOTFILES=$XDG_CONFIG_HOME/dotfiles
export KEYTIMEOUT=1

# Make Apple Terminal behave.
export SHELL_SESSIONS_DISABLE=1

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

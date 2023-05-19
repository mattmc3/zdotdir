#
# .zshenv - Zsh environment file, loaded always.
#

export ZDOTDIR=~/.config/zsh

#region paths

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
export XDG_RUNTIME_DIR=~/.xdg
export XDG_PROJECTS_DIR=~/Projects

# Homebrew
if [[ -e /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
else
  export HOMEBREW_PREFIX=/usr/local
fi

# Custom
export DOTFILES=$XDG_CONFIG_HOME/dotfiles
export GLOBALGOPATH=$XDG_PROJECTS_DIR/golang
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export REPO_HOME=$XDG_CACHE_HOME/repos
export ANTIDOTE_HOME=$REPO_HOME
export LESSHISTFILE=$XDG_CACHE_HOME/less/history

# Zsh completion dump
ZSH_COMPDUMP=$XDG_CACHE_HOME/prezto/zcompdump

# Ensure path arrays do not contain duplicates.
typeset -gU fpath path cdpath

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
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
  $XDG_CONFIG_HOME/emacs/bin(N)

  # apps
  /{usr/local,opt/homebrew}/opt/curl/bin(N)
  /{usr/local,opt/homebrew}/opt/go/libexec/bin(N)
  /{usr/local,opt/homebrew}/share/npm/bin(N)
  /{usr/local,opt/homebrew}/opt/ruby/bin(N)
  /{usr/local,opt/homebrew}/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)

  # path
  $path
)

#endregion

#region apps

export EDITOR=hx
export VISUAL=code
export PAGER=less
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#endregion

#region customizations

# Regional settings
export LANG='en_US.UTF-8'

# Less
export LESS='-g -i -M -R -S -w -z-4'

# Misc
export KEYTIMEOUT=1
export SHELL_SESSIONS_DISABLE=1 # Make Apple Terminal behave.

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Plugins
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'
ZSH_COMPDUMP=$XDG_CACHE_HOME/prezto/zcompdump
_Z_DATA=$XDG_DATA_HOME/z/data
[[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h

#endregion

# vim: ft=zsh sw=2 ts=2 et

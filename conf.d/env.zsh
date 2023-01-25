###
# Setup environment.
###

# Many of these apps use XDG locations
# XDG basedir support outlined here:
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# antidote
[[ -n "$ANTIDOTE_HOME" ]] || ANTIDOTE_HOME="$(antidote home)"

# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# brew (brew shellenv)
if (( $+commands[brew] )); then
  export HOMEBREW_NO_ANALYTICS=1
  [[ -n "$HOMEBREW_PREFIX" ]] || HOMEBREW_PREFIX=$(brew --prefix)
fi

# dotfiles
export DOTFILES=${DOTFILES:-~/.config/dotfiles}

# editors
export EDITOR=hx
export VISUAL=code

# go
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH

# groovy
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=$HOMEBREW_PREFIX/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi

# history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# magic-enter
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'

# ohmyzsh
ZSH=$ANTIDOTE_HOME/ohmyzsh/ohmyzsh

# perl
# if [[ "$OSTYPE" == darwin* ]]; then
#   # eval "$(perl -I$XDG_DATA_HOME/perl5/lib/perl5 -Mlocal::lib=$XDG_DATA_HOME/perl5)"
#   export PERL_MB_OPT='--install_base "$XDG_DATA_HOME/perl5"'
#   export PERL_MM_OPT='INSTALL_BASE=$XDG_DATA_HOME/perl5'
#   if [[ ! -d $XDG_DATA_HOME/perl5 ]]; then
#     mkdir -p $XDG_DATA_HOME/perl5
#     cpan local::lib
#   fi
# fi

# zsh-abbr
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr

# Set $PATH.
path=(
  # core
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)

  # emacs
  $HOME/.emacs.d/bin(N)
  $HOME/.config/emacs/bin(N)

  # apps
  $HOMEBREW_PREFIX/opt/curl/bin(N)
  $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
  $HOMEBREW_PREFIX/share/npm/bin(N)

  $path
)

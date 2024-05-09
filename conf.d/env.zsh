###
# Setup environment.
###

# dotfiles
export DOTFILES=${DOTFILES:-~/.config/dotfiles}

# user specific
export USER_CONFIG=${USER_CONFIG:-~/.config/.zsh_user}

# editors
export EDITOR=nvim
export VISUAL=code

export NVIMCONFIG=${NVIMCONFIG:-~/.config/nvim}
export LVIMCONFIG=${LVIMCONFIG:-~/.config/lvim}
export ASTROUSERCONFIG=${ASTROUSERCONFIG:-~NVIMCONFIG/lua/user}

# go
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH

# groovy
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=$HOMEBREW_PREFIX/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi

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

# Set $PATH.
path=(
  # core
  $HOME/{,s}bin(N)
  $HOME/.rye/shims
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

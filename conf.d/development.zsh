#
# Development tools
#

path+=(
  ${CARGO_HOME:-?}/bin(N)
  ${GOPATH:-?}/bin(N)
  ${NIMBLE_DIR:-$HOME/.nimble}/bin(N)
  $HOME/.dotnet/tools(N)
  $XDG_CONFIG_HOME/emacs/bin(N)
  $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
  $HOMEBREW_PREFIX/opt/postgresql@18/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/share/npm/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)

# Java
alias setjavahome='export JAVA_HOME=$(/usr/libexec/java_home)'

# Perl
if [[ "$OSTYPE" == darwin* ]]; then
  export PERL_MB_OPT="--install_base $XDG_DATA_HOME/perl5"
  export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"

  if [[ ! -d $XDG_DATA_HOME/perl5 ]]; then
    mkdir -p "$XDG_DATA_HOME/perl5"
    cpan local::lib
  fi
fi

# Ruby
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"

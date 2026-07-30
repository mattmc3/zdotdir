#
# Perl
#

if [[ "$OSTYPE" == darwin* ]]; then
  export PERL_MB_OPT="--install_base $XDG_DATA_HOME/perl5"
  export PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"

  if [[ ! -d $XDG_DATA_HOME/perl5 ]]; then
    mkdir -p "$XDG_DATA_HOME/perl5"
    cpan local::lib
  fi
fi

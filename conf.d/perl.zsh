#
# perl
#

if [[ "$OSTYPE" == darwin* ]]; then
  # eval "$(perl -I$XDG_DATA_HOME/perl5/lib/perl5 -Mlocal::lib=$XDG_DATA_HOME/perl5)"
  export PERL_MB_OPT='--install_base "$XDG_DATA_HOME/perl5"'
  export PERL_MM_OPT='INSTALL_BASE=$XDG_DATA_HOME/perl5'
  if [[ ! -d $XDG_DATA_HOME/perl5 ]]; then
    mkdir -p $XDG_DATA_HOME/perl5
    cpan local::lib
  fi
fi

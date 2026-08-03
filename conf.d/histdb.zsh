#
# histdb: SQLite shell history
#

histdb_bin=(
  /opt/homebrew/bin/histdb(N)
)

if (( $#histdb_bin )); then
  if (( $+functions[cached-eval] )); then
    cached-eval $histdb_bin[1] init zsh
  else
    source <($histdb_bin[1] init zsh)
  fi
fi
unset histdb_bin

# Ensure python commands exist.
if (( $+commands[python3] )) && ! (( $+commands[python] )); then
  alias python=python3
fi
if (( $+commands[pip3] )) && ! (( $+commands[pip] )); then
  alias pip=pip3
fi

# Ensure envsubst command exists.
if ! (( $+commands[envsubst] )); then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi

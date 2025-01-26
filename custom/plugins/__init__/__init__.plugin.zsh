# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Make missing dirs
for _zdir in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME
do
  [[ -d "$_zdir" ]] || mkdir -p -- "$_zdir"
done
unset _zdir

# Make Terminal.app behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=1
fi

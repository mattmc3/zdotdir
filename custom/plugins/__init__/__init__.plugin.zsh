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

# Add any missing ZSH_CUSTOM repos
repos=(
  mattmc3/zman
  zdharma-continuum/fast-syntax-highlighting
  romkatv/zsh-no-ps2
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
)
for repo in $repos; do
  if [[ ! -d $ZSH_CUSTOM/plugins/${repo:t} ]]; then
    git -C $ZSH_CUSTOM/plugins clone --quiet --depth 1 https://github.com/$repo
  fi
done

# Make Terminal.app behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=1
fi

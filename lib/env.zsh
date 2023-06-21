# zsh dirs
export __zsh_config_dir=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}/zsh}
export __zsh_user_data_dir=${XDG_DATA_HOME:=$HOME/.local/share}/zsh
export __zsh_cache_dir=${XDG_CACHE_HOME:=$HOME/.cache}/zsh

for _zdir in $__zsh_config_dir $__zsh_user_data_dir $__zsh_cache_dir; do
  [[ -d $_zdir ]] || mkdir -p $_zdir
done

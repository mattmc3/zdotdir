: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}

() {
  local -a _cache_files=($__zsh_cache_dir/zcust_zoxide.zsh(Nmh-20))
  if ! (( $#_cache_files )); then
    zoxide init zsh 2> /dev/null >| $__zsh_cache_dir/zcust_zoxide.zsh
  fi
  source $__zsh_cache_dir/zcust_zoxide.zsh
}

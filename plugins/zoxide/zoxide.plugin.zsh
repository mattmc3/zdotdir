# zoxide

# Pre-reqs.
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
[[ -d $__zsh_cache_dir ]] || mkdir -p $__zsh_cache_dir

# Use cached init.
() {
  local -a cache=($__zsh_cache_dir/zoxide.init.zsh(Nmh-20))
  if ! (( $#cache )); then
    zoxide init zsh 2> /dev/null >| $__zsh_cache_dir/zoxide.init.zsh
  fi
  source $__zsh_cache_dir/zoxide.init.zsh
}

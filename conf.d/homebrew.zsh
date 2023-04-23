### brew - Functions for brew users
# References:
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/homebrew

(( $+commands[brew] )) || return 1

# Setup cache dir.
_cache_dir=${XDG_CACHE_HOME:=$HOME/.cache}/zsh/brew
[[ -d $_cache_dir ]] || mkdir -p $_cache_dir

# Generate a new cache file daily.
typeset -a _cache_files=($_cache_dir/brew_shellenv.zsh(Nmh-20))
(( $#_cache_files )) || brew shellenv 2> /dev/null >| $_cache_dir/brew_shellenv.zsh
source $_cache_dir/brew_shellenv.zsh
unset _cache_{dir,files}

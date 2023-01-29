###
# brew - Functions for brew users.
#
# References:
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/homebrew
###

export HOMEBREW_NO_ANALYTICS=1

_brewcmd=brew
if (( ! $+commands[brew] )); then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    _brewcmd="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    _brewcmd="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    _brewcmd="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    _brewcmd="$HOME/.linuxbrew/bin/brew"
  else
    unset _brewcmd
    return 1
  fi
fi

# cache dir
_cache_dir=${XDG_CACHE_HOME:=$HOME/.cache}/zsh
[[ -d $_cache_dir ]] || mkdir -p $_cache_dir

# generate a new cache file daily
typeset -a _cache_files=($_cache_dir/brew.zsh(Nmh-20))
(( $#_cache_files )) ||
  $_brewcmd shellenv >| $_cache_dir/brew.zsh
source $_cache_dir/brew.zsh

# load plugin functions
fpath=(${0:A:h}/functions $fpath)
autoload -U $fpath[1]/*(.:t)

#
# Wrap up
#

unset _brewcmd _cache_{dir,files}

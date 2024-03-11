#
# antidote: The fastest Zsh plugin manager.
#

# Setup antidote.
: ${ANTIDOTE_HOME:=${XDG_CACHE_HOME:-~/.cache}/repos}
zstyle -s ':antidote:repo' path antidote_path \
  || antidote_path=$ANTIDOTE_HOME/mattmc3/antidote

# Clone antidote if missing.
[[ -d $antidote_path ]] \
  || git clone --depth 1 --quiet https://github.com/mattmc3/antidote $antidote_path

# Lazy-load antidote from its functions directory.
fpath=($antidote_path/functions $fpath)
autoload -Uz antidote

# Generate static file in a subshell whenever .zsh_plugins.txt is updated.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh)
fi

# Don't source the static file until zzz.

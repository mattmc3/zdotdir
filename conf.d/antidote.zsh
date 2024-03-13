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

# Generate static file in a subshell whenever .zplugins.txt is updated.
zplugins=${ZDOTDIR:-~}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins}.txt ]] || [[ ! -d $ANTIDOTE_HOME ]]; then
  (antidote bundle <${zplugins}.txt >|${zplugins}.zsh)
fi

# Source the static file.
source ${zplugins}.zsh

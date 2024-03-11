#
# .zshrc - Run on interactive Zsh session.
#

# load lib
ZSH_CUSTOM=$ZDOTDIR
for _zrcfile in $ZDOTDIR/lib/*.zsh; do
  source $_zrcfile
done

# Setup antidote.
export ANTIDOTE_HOME=${XDG_CACHE_HOME:-~/.cache}/repos
antidote_path=$ANTIDOTE_HOME/mattmc3/antidote

# keep all 3 for different test scenarios
# antidote_path=$ANTIDOTE_HOME/mattmc3/antidote
# antidote_path=~/Projects/mattmc3/antidote/antidote.zsh
# antidote_path=${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh

# Clone antidote.
[[ -d $antidote_path ]] \
  || git clone --depth 1 --quiet https://github.com/mattmc3/antidote $antidote_path

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Lazy-load antidote from its functions directory.
fpath=($antidote_path/functions $fpath)
autoload -Uz antidote

# Generate static file in a subshell whenever .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source the antidote static plugins file.
source $zsh_plugins

# Set prompt.
myprompt p10k mmc

# Initialize completions.
mycompinit

# Always succeed.
true

# vim: ft=zsh sw=2 ts=2 et

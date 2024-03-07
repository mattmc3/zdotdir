#
# .zshrc - Run on interactive Zsh session.
#

# load lib
ZSH_CUSTOM=$ZDOTDIR
for _zrcfile in $ZDOTDIR/lib/*.zsh; do
  source $_zrcfile
done

# Use antidote for plugin management.
export ANTIDOTE_HOME=${XDG_CACHE_HOME:=~/.cache}/repos
antidote_path=$ANTIDOTE_HOME/mattmc3/antidote

# keep all 3 for different test scenarios
# antidote_path=$ANTIDOTE_HOME/mattmc3/antidote
# antidote_path=~/Projects/mattmc3/antidote/antidote.zsh
# antidote_path=${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh

# Load antidote.
[[ -d $antidote_path ]] \
  || git clone --depth 1 --quiet https://github.com/mattmc3/antidote $antidote_path
source $antidote_path/antidote.zsh
antidote load

# Set prompt.
doprompt p10k mmc

# Initialize completions.
docompinit

# Always succeed.
true

# vim: ft=zsh sw=2 ts=2 et

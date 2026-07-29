#
# carapace: Cross shell completions.
#

if (( ${+commands[carapace]} )); then
  export CARAPACE_BRIDGES="${CARAPACE_BRIDGES:-zsh,fish,bash}"
  source <(carapace _carapace)
fi

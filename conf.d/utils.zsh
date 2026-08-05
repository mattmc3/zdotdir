# project jumper
cached-eval prj -i zsh
# SQLite history
cached-eval histdb init zsh
# .envrc source
cached-eval direnv hook zsh
# syntax highlighting
cached-eval zsh-patina activate
# frecency cd replacement
cached-eval zoxide init zsh
# x-shell completions
export CARAPACE_BRIDGES="${CARAPACE_BRIDGES:-fish,bash}"
cached-eval carapace _carapace

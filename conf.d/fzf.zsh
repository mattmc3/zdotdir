#
# fzf: Configure the fuzzy finder.
#

# https://github.com/ajeetdsouza/fzf
if ! (( $+commands[fzf] )); then
  print -ru2 "fzf not found"
  return 1
fi

function init_fzf() {
  if (( $+functions[cached-eval] )); then
    cached-eval fzf --zsh
  else
    source <(fzf --zsh)
  fi
}

if (( $+functions[zvm_version] )); then
  zvm_after_init_commands+=(init_fzf)
else
  init_fzf
fi

# Use fzf for tab completions
# antidote bundle aloxaf/fzf-tab

# fzf-tab ignores %F{}/%f prompt-escape sequences in completion format
# zstyles (see fzf-tab README "Configure" section) - reset to plain text
# so headers don't leak raw escape codes into the fzf display.
zstyle ':completion:*:corrections' format ' -- %d (errors: %e) --'
zstyle ':completion:*:descriptions' format ' -- %d --'
zstyle ':completion:*:messages' format ' -- %d --'
zstyle ':completion:*:warnings' format ' -- no matches found --'
zstyle ':completion:*' format ' -- %d --'

# _match/_approximate are redundant once fzf-tab provides interactive
# fuzzy filtering, and their "original"/"corrections" group headers
# get squashed together under group-name ''. Plain completion only.
zstyle ':completion:*' completer _complete

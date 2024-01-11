#
# abbreviations
#

# References:
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/globalias/globalias.plugin.zsh
# - https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
# - https://dev.to/frost/fish-style-abbreviations-in-zsh-40aa

function globalias {
  local -a noexpand_aliases
  zstyle -a ':zsh_custom:plugin:abbreviations' 'noexpand' 'noexpand_aliases' \
    || noexpand_aliases=()

  # Get last word to the left of the cursor:
  # (A) makes it an array even if there's only one element
  # (z) splits into words using shell parsing
  local word=${${(Az)LBUFFER}[-1]}
  if [[ $noexpand_aliases[(Ie)$word] -eq 0 ]]; then
    zle _expand_alias
    # zle expand-word
  fi
  zle self-insert
}
zle -N globalias

#
# Keybindings
#

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

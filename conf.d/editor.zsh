#
# Line editor
#

dot-expansion() {
  if [[ $LBUFFER == *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N dot-expansion

bindkey -M emacs . dot-expansion
bindkey -M viins . dot-expansion
bindkey -M isearch . self-insert

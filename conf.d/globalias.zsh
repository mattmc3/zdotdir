0=${(%):-%N}

# Fish-like abbreviation expansion via zsh global aliases.
# Space expands the last word if it's an alias; Enter expands then accepts.
# Alt+Space inserts a literal space without expanding.
# Add words to skip via: zstyle ':zsh_custom:plugin:globalias' noexpand 'word' ...

typeset -gA _globalias_noexpand
() {
  local -a _words
  local _w
  zstyle -a ':zsh_custom:plugin:globalias' noexpand '_words'
  for _w in "${_words[@]}"; do
    _globalias_noexpand[$_w]=1
  done
}

_globalias_expand_word() {
  local word=${${(Az)LBUFFER}[-1]}
  (( $+_globalias_noexpand[$word] )) && return
  (( $+galiases[$word] || ! $+commands[$word] )) && zle _expand_alias
}

globalias-space() {
  _globalias_expand_word
  zle self-insert
}
zle -N globalias-space

globalias-accept() {
  _globalias_expand_word
  zle accept-line
}
zle -N globalias-accept

for _ga_keymap in emacs viins; do
  bindkey -M "$_ga_keymap" ' '  globalias-space
  bindkey -M "$_ga_keymap" '\e ' magic-space
  bindkey -M "$_ga_keymap" '^M' globalias-accept
done
bindkey -M isearch ' ' magic-space
unset _ga_keymap

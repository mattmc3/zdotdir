# function glob-alias {
#    # Get last word to the left of the cursor:
#    # (z) splits into words using shell parsing
#    # (A) makes it an array even if there's only one element
#    local word=${${(Az)LBUFFER}[-1]}
#    if [[ $GLOBALIAS_FILTER_VALUES[(Ie)$word] -eq 0 ]]; then
#       zle _expand_alias
#       zle expand-word
#    fi
#    zle self-insert
# }
# zle -N glob-alias

# # space expands all aliases, including global
# bindkey -M emacs " " glob-alias

# # control-space to make a normal space
# bindkey -M emacs "^ " magic-space

# # normal space during searches
# bindkey -M isearch " " magic-space


# # Inserts 'sudo ' at the beginning of the line.
# function prepend-sudo {
#   if [[ "$BUFFER" != su(do|)\ * ]]; then
#     BUFFER="sudo $BUFFER"
#     (( CURSOR += 5 ))
#   fi
# }
# zle -N prepend-sudo
# bindkey -M emacs "$key_info[Control]X$key_info[Control]S" prepend-sudo


# # Expand .... to ../..
# function expand-dot-to-parent-directory-path {
#   if [[ $LBUFFER = *.. ]]; then
#     LBUFFER+='/..'
#   else
#     LBUFFER+='.'
#   fi
# }
# zle -N expand-dot-to-parent-directory-path
# bindkey -M emacs '.' expand-dot-to-parent-directory-path
# # Do not expand .... to ../.. during incremental search.
# bindkey -M isearch . self-insert 2> /dev/null

# # Allow command line editing in an external editor.
# autoload -Uz edit-command-line
# zle -N edit-command-line

# # Emacs keybindings
# bindkey -e

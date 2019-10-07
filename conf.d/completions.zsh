### completions ------------------------------------------------------------ {{{
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files

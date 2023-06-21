#
# editor - Set keybindings.
#
# https://github.com/sorin-ionescu/prezto/blob/master/modules/editor/init.zsh

#
# zstyles
#

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'emacs'

# Expand ... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Set this to whatever you want to use to edit a command
zstyle :zle:edit-command-line editor ${EDITOR:-vim}

#
# Prezto
#

# Load plugin functions.
0=${(%):-%N}
source ${0:A:h}/external/prezto_editor.zsh

# undo bad prezto settings
unsetopt BEEP

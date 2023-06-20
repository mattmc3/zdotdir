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
# Oh-My-Zsh
#

plugin-load ohmyzsh/ohmyzsh/plugins/magic-enter \
            ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z

# magic-enter
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'

#
# Prezto
#

plugin-load sorin-ionescu/prezto/modules/editor

# undo bad prezto settings
unsetopt BEEP

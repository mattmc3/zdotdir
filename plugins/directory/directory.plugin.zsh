#
# directory - set directory options and aliases
#

# Use Prezto directory module.
plugin-load sorin-ionescu/prezto/modules/directory

# undo bad Prezto settings
# unsetopt AUTO_CD    # Do not auto change to a directory without typing cd.
# unalias d

# set other directory options
setopt PUSHD_MINUS  # Swap meanings of +/- to be more natural.

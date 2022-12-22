#
# Set directory options and define directory aliases.
#

# https://github.com/sorin-ionescu/prezto/blob/master/modules/directory/init.zsh

#
# Options
#

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt NO_AUTO_CD           # Auto changes to a directory without typing cd.
setopt NO_CLOBBER           # Do not overwrite existing files with > and >>. Use >! and >>! to bypass.

#
# Aliases
#

alias -- -='cd -'
alias dirh='dirs -v'
for _idx ({1..9}) alias "$_idx"="cd +${_idx}"; unset _idx
